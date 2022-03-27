//
//  NetworkManager.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 18.03.2022.
//

import Foundation

// MARK: - Protocol
protocol NetworkManagerProtocol: AnyObject {
    static func dataTask (_ endPoint: NetworkManager.EndPoint, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

// MARK: - Class
class NetworkManager {
    
    enum EndPoint {
//        static let per_page = 20
//        private var baseURL: URL { URL(string: "https://pixabay.com/api")! }
//        private var key: String { "25724093-3271289b67930f6caed039a98" }
        
        case items(Int, String)
        case image(String)
        
        var request: URLRequest? {
            
            switch self {
                case .items(let page, let filter):
                    guard let url = URL(string: "https://pixabay.com/api/?key=25724093-3271289b67930f6caed039a98&q=\(filter)&image_type=photo&page=\(page)&per_page=20") else { return nil }
                    return URLRequest(url: url)
                
                case .image(let url):
                    guard let url = URL(string: url) else { return nil }
                    return URLRequest(url: url)
            }
            
        }
        
    }
    
}

// MARK: - NetworkManagerProtocol
extension NetworkManager: NetworkManagerProtocol {
    
    static func dataTask (_ endPoint: EndPoint, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let request = endPoint.request else { return }
        
        //TODO: - Убрать и настроить отображение ячеек (не работает из кеша) - наверное с потоками чтото dataTask
        /// ---
        if let cachedResponse = URLSession.shared.configuration.urlCache?.cachedResponse(for: request) {
            return completion(cachedResponse.data, cachedResponse.response, nil)
        }
        /// ---
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data, let response = response {
                return completion(data, response, nil)
            }
            
            if let error = error {
                print(error.localizedDescription)
                
                if let cachedResponse = URLSession.shared.configuration.urlCache?.cachedResponse(for: request) {
                    return completion(cachedResponse.data, cachedResponse.response, error)
                }
            }
            
            completion(data, response, error)
        }
        dataTask.resume()
    }
    
    
}

