//
//  ItemCache.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 25.02.2022.
//

import UIKit

class ItemCache {
    
    class Item {
        let image: UIImage
        let date: Date
        
        init(image: UIImage, date: Date) {
            self.image = image
            self.date = date
        }
    }
    
    private lazy var cachedItems =  NSCache<NSURL, Item>()
    
    func removeAllObjects() {
        cachedItems.removeAllObjects()
    }
    
    subscript (url: URL) -> Item? {
        get {
            item(url)
        }
        set {
            if let item = newValue {
                appendImage(url: url, item: item)
            }
        }
    }
    
    private func item (_ url: URL) -> Item? {
        if let cashedItem = cachedItems.object(forKey: url as NSURL) {
            return cashedItem
        }
        return nil
    }
    
    private func appendImage(url: URL, item: Item) {
        cachedItems.setObject(item, forKey: url as NSURL)
    }
    
    
}
