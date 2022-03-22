//
//  NetworkManager.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 18.03.2022.
//

import Foundation

// MARK: - Protocol
protocol NetworkManagerProtocol: AnyObject {
    
}

// MARK: - Class
class NetworkManager {

    //"https://pixabay.com/api/?key=25724093-3271289b67930f6caed039a98&q=red&image_type=photo&page=1&per_page=20"
    lazy var url: URL? = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pixabay.com"
        urlComponents.path = "/api/"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: "25724093-3271289b67930f6caed039a98"),
            URLQueryItem(name: "q", value: "red"),
            URLQueryItem(name: "image_type", value: "photo"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "per_page", value: "20")]

        return urlComponents.url
    }()
    
}

// MARK: - NetworkManagerProtocol
extension NetworkManager: NetworkManagerProtocol {
    
}


//func setup(data: DetailsModel) {
//        self.navigationItem.title = ""
//        self.navigationItem.setSubTitle("")
//        if let item = item {
//            self.navigationItem.title = String(item.id)
//            guard let url = URL(string: item.largeImageURL) else { return }
//            MDCachedData.shared.fetchDataByUrl(url.absoluteString) { [unowned self] data, error in
//                if error == nil, let data = data {
//                    guard let decodeData = try? JSONDecoder().decode(MDCachedData.DataItem.self, from: data) else { return }
//                    if let image = UIImage(data: decodeData.data) {
//                        DispatchQueue.main.async { [weak self] in
//                            self?.navigationItem.setSubTitle(decodeData.date.toStringFormat("d MMMM YYYY HH:mm:ss"))
//                            self?.imageView.image = image
//                            self?.progress.stopAnimating()
//                            self?.progress.isHidden = true
//                        }
//                    }
//                }
//            }
//        }
// }
