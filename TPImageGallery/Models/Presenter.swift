//
//  Presenter.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 25.02.2022.
//

import UIKit

class Presenter {
    
    private let cache: ItemCache
    
    var items = [Item]()
    
    init(cache: ItemCache = ItemCache()) {
        self.cache = cache
    }
    
    func fetchItems(_ urlString: String, completion: @escaping () -> Void ) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, _) -> Void in
            if let data = data {
                do {
                    let dataJsone = try JSONDecoder().decode(DataImages.self, from: data)
                    self.items = dataJsone.items
                    completion()
                } catch  {
                    print("error: \(error)")
                }
            }
        }).resume()
        
    }
    
    func loadItem (url: String, completion: @escaping (ItemCache.Item?) -> Void ) {
        
        guard let url = URL(string: url) else { return }
        
        if let cashedItem = cache[url] {
            completion(cashedItem)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data, let image = UIImage(data: data) {
                let item = ItemCache.Item(image: image, date: Date())
                self.cache[url] = item
                completion(item)
                return
            }
        }.resume()
        
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
    
    
}
