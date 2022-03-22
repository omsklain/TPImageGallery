//
//  MDCacheProtocol.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 08.03.2022.
//

import Foundation

public protocol MDCacheProtocol {
    associatedtype T
    func load(forKey key: String) throws -> T?
    func save(_ data: T, forKey key: String) throws
}

