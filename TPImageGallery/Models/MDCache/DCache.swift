//
//  DCache.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 08.03.2022.
//

import Foundation

public final class DCache<T>: MDCacheProtocol where T: Codable {

    public func load(forKey key: String) throws -> T? {
        let filePathURL = try filePathURL(forKey: key)
        guard let data = try? data(of: filePathURL) else {
            return nil
        }
        
        let value = try JSONDecoder().decode(T.self, from: data)
        return value
    }
    
    public func save(_ data: T, forKey key: String) throws {
        let filePathURL = try filePathURL(forKey: key)
        try assureDirectoryExists(filePathURL: filePathURL)
        
        let data = try JSONEncoder().encode(data)
        try write(data, to: filePathURL)
    }

    func assureDirectoryExists(filePathURL: URL) throws {
        if FileManager.default.fileExists(atPath: filePathURL.path) == false {
            try FileManager.default.createDirectory(at: filePathURL.deletingLastPathComponent(), withIntermediateDirectories: true)
        }
    }
    
    func filePathURL(forKey key: String) throws -> URL {
        try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("DCache")
            .appendingPathComponent(key)
    }
    
    func write(_ data: Data, to url: URL) throws {
        try data.write(to: url)
    }
    
    func data(of url: URL) throws -> Data {
        try Data(contentsOf: url)
    }
    
}
