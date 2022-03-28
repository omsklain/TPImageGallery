//
//  DataSourceManager.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 27.03.2022.
//

import Foundation

protocol DataSourceManagerProtocol: AnyObject {
    func fetch (_ urlString: String, completion: @escaping (_ data: DataSourceManager.Model?, _ error: Error?) -> () )
}

class DataSourceManager {
    
    static let shared = DataSourceManager()
    
    /// Model cached
    struct Model: Codable {
        let data: Data
        let date: Date
    }
    
    // MARK: - Internal vars
    private var mdCache = MDCache<Data>()
    private var session = URLSession.shared
    
    // MARK: - Internal logics
    private func loadData (_ forKey: String) -> Data? {
        do {
            return try mdCache.load(forKey: forKey)
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

// MARK: - NetworkManagerProtocol
extension DataSourceManager: DataSourceManagerProtocol {
    
    func fetch (_ urlString: String, completion: @escaping (_ data: Model?, _ error: Error?) -> () ) {
        /// Reading model
        if let data = self.loadData(urlString), let model = try? JSONDecoder().decode(Model.self, from: data) {
            return completion(model, nil)
        }
        
        guard let url = URL(string: urlString) else { return }
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                return completion(nil, error)
            } else if let data = data, let response = response {
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
                
                let model = Model(data: data, date: Date())
                /// Saving model
                if let encodeData = try? JSONEncoder().encode(model) {
                    self.saveData(encodeData, forKey: urlString)
                }
                DispatchQueue.main.async {
                    return completion(model, nil)
                }
            }
        }
        dataTask.resume()
    }
    
}
