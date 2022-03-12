//
//  MDCachedData.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 08.03.2022.
//

import UIKit

class MDCachedData {

    struct DataItem: Codable {
        let data: Data
        let date: Date
    }
    
    private var mdCache = MDCache<Data>()
    
    static var shared = MDCachedData()
    
    subscript (forKey key: String) -> Data? {
        get {
            return self.loadData(key)
        }
        set {
            if let data = newValue {
                saveData(data, forKey: key)
            }
        }
    }

    func fetchDataByUrl(_ urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> () ) {
        if let data = self.loadData(urlString) {
            completion(data, nil)
            return
        }
        guard let url = URL(string: urlString) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
            } else if let data = data, let response = response {
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
                let dataItem = DataItem(data: data, date: Date())
                if let encodeData = try? JSONEncoder().encode(dataItem) {
                    self.saveData(encodeData, forKey: urlString)
                    completion(encodeData, nil)
                }
            }
        }
        dataTask.resume()
    }
    
    func removeCachedData() {
        do {
            try mdCache.removeAllObjects()
        } catch {
            print("MDCachedData:removeCachedData:error: \(error)")
        }
        
    }
    
    // MARK: - Private functions
 
    private func loadData (_ forKey: String) -> Data? {
        do {
            let data = try mdCache.load(forKey: forKey)
            return data
        } catch {
            print("MDCachedData:loadData:error: \(error)")
        }
        return nil
    }
    
    private func saveData (_ data: Data, forKey: String) {
        do {
            try mdCache.save(data, forKey: forKey)
        } catch {
            print("MDCachedData:saveData:error: \(error)")
        }
    }
    
    
}
