//
//  DataImages.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 16.02.2022.
//

import Foundation

struct Item: Decodable {
    
    var id: Int
    var webformatURL: String
    var largeImageURL: String
    var views: Int
    var downloads: Int
    var likes: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case webformatURL
        case largeImageURL
        case views
        case downloads
        case likes
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        webformatURL = try values.decode(String.self, forKey: .webformatURL)
        largeImageURL = try values.decode(String.self, forKey: .largeImageURL)
        views = try values.decode(Int.self, forKey: .views)
        downloads = try values.decode(Int.self, forKey: .downloads)
        likes = try values.decode(Int.self, forKey: .likes)
    }
    
    
}

struct DataImages: Decodable {

    var items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case items = "hits"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decode([Item].self, forKey: .items)
    }
    
    
}
