//
//  MCache.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 25.02.2022.
//

import UIKit

public final class MCache<T>: MDCacheProtocol where T: Codable {
    
    private typealias cacheType = NSCache<NSString, NSData>

    private lazy var cache: cacheType = {
        let cache = cacheType()
        return cache
    }()

    public func load (forKey key: String) throws -> T? {
        try cache
            .object(forKey: NSString(string: key))
            .flatMap { Data(referencing: $0) }
            .flatMap { try JSONDecoder().decode(T.self, from: $0) }
    }
    
    public func save (_ value: T, forKey key: String) throws {
        let data = try JSONEncoder().encode(value)
        cache.setObject(NSData(data: data), forKey: NSString(string: key))
    }

    
}
