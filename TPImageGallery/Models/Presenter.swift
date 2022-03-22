////
////  Presenter.swift
////  TPImageGallery
////
////  Created by Константин Туголуков on 07.03.2022.
////
//
//import Foundation
//import UIKit
//
//class Presenter {
//    
//    let dCachedItems = DCache<[Item]>()
//    
//    var fetchPageNumber: Int = 1
//    
//    var items: [Item] = [] {
//        didSet {
//            do {
//               try dCachedItems.save(items, forKey: "itemsData")
//            } catch {
//                print("\(error)")
//            }
//        }
//    }
//
//    init() {
//        let loaditems = loadItemsCache()
//        if loaditems.count > 20 {
//            self.items = loaditems
//        }
//    }
//    
//    func loadItemsCache() -> [Item] {
//        do {
//            if let data = try dCachedItems.load(forKey: "itemsData") {
//                return data
//            }
//        } catch {
//            print("\(error)")
//        }
//        return []
//    }
//    
//    func getNextUrl() -> URL? {
//        let urlString = "https://pixabay.com/api/?key=25724093-3271289b67930f6caed039a98&q=red&image_type=photo&page=\(fetchPageNumber)&per_page=20"
//        return URL(string: urlString)
//    }
//    
//    func appendItemsNextPage(complition: @escaping () -> ()) {
//        self.fetchPageNumber += 1
//        fetchItems(){
//            complition()
//        }
//    }
//
//    func fetchItems(complition: @escaping () -> ()) {
//        guard let url = self.getNextUrl() else { return }
//        MDCachedData.shared.fetchDataByUrl(url.absoluteString) { [unowned self] data, error in
//            if error == nil, let data = data {
//                do {
//                    if  let decodeData = try? JSONDecoder().decode(MDCachedData.DataItem.self, from: data) {
//                        let dataJson = try JSONDecoder().decode(DataImages.self, from: decodeData.data)
//                        self.items.append(contentsOf: dataJson.items)
//                        complition()
//                    }
//                } catch  {
//                    print("JSONDecoder:error: \(error)")
//                }
//            }
//        }
//    }
//    
//}
