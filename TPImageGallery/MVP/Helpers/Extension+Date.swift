//
//  Extension+Date.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 26.02.2022.
//

import Foundation

extension Date {
    
    func toStringFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: self)
    }
    
    func toStringFormat(_ date: Date, _ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: self)
    }
    
    
}
