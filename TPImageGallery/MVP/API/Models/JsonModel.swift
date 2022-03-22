//
//  JsonModel.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 19.03.2022.
//

import Foundation

struct JsonModel {
    
    //MARK: - JSONModel model
    struct Model: Decodable {
        
        let total: Int
        let totalHits: Int
        let items: [Item]
        
        enum CodingKeys: String, CodingKey {
            case total = "total"
            case totalHits = "totalHits"
            case items = "hits"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            total = try values.decode(Int.self, forKey: .total)
            totalHits = try values.decode(Int.self, forKey: .totalHits)
            items = try values.decode([Item].self, forKey: .items)
        }
    }
    
    //MARK: - Item model
    struct Item: Decodable, Encodable {
        
        let id: Int
        let webformatURL: String
        let largeImageURL: String
        let views: Int
        let downloads: Int
        let likes: Int
        
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
    
    
}




