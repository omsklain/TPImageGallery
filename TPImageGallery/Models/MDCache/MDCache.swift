//
//  MDCache.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 08.03.2022.
//

import Foundation

public final class MDCache<T>: MDCacheProtocol where T: Codable {
    
    private let memory: MCache<T>
    private let disk: DCache<T>
    
    init(memory: MCache<T> = .init(), disk: DCache<T> = .init()) {
        self.memory = memory
        self.disk = disk
    }
    
    public func load (forKey key: String) throws -> T? {
        if let memoryData = try memory.load(forKey: key) {
            return memoryData
        }
        
        if let diskData = try disk.load(forKey: key) {
            try memory.save(diskData, forKey: key)
            return diskData
        }
        
        return nil
    }
    
    public func save (_ data: T, forKey key: String) throws {
        try memory.save(data, forKey: key)
        try disk.save(data, forKey: key)
    }

    
}
