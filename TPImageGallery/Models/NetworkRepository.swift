//
//  NetworkRepository.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 04.03.2022.
//

import Foundation
import UIKit

class NetworkRepository {

    struct DataItem: Codable {
        let data: Data
        let date: Date
    }

    static var shared = NetworkRepository()

    lazy var cache: URLCache = {
        let cache = URLCache()
        cache.memoryCapacity = 50 * 1024 * 1024
        cache.diskCapacity = 50 * 1024 * 1024
        return cache
    }()

    lazy var session: URLSession = {
        let configur = URLSessionConfiguration.default
        configur.urlCache = cache
        configur.requestCachePolicy = .returnCacheDataElseLoad

        return URLSession(configuration: configur)
    }()

    func fetchCachedDataUrl_(url: URL, completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        if let data = self.cache.cachedResponse(for: request)?.data {
            completion(data, nil)
            return
        } else {
            let dataTask = self.session.dataTask(with: request) { [unowned self] data, response, error in
                if let error = error {
                    completion(nil, error)
                    return
                } else if let data = data, let response = response {
                    guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
                    let dataItem = NetworkRepository.DataItem(data: data, date: Date())
                    if let encodeData = try? JSONEncoder().encode(dataItem) {
                        let cachedURLResponse = CachedURLResponse(response: response, data: encodeData)
                        self.cache.storeCachedResponse(cachedURLResponse, for: request)
                        completion(encodeData, nil)
                    }
                }
            }
            dataTask.resume()
        }
    }

    func decodeData(_ data: Data) throws ->  NetworkRepository.DataItem? {
        let dataDecode = try? JSONDecoder().decode(NetworkRepository.DataItem.self, from: data)
        return dataDecode
    }

}

