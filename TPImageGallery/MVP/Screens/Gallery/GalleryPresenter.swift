//
//  GalleryPresenter.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 19.03.2022.
//

import UIKit

protocol GalleryPresenterProtocol {
    init(viewController: GalleryViewProtocol, router: RouterProtocol)
    var items: [GalleryCellModel] { get set }
    func fetchItems()
    func showDetails(indexPath: IndexPath)
}

// MARK: - Class
class GalleryPresenter: GalleryPresenterProtocol {

    // MARK: - External vars
    var router: RouterProtocol?
    weak var viewController: GalleryViewProtocol?
    var items = [GalleryCellModel]()
    
    required init(viewController: GalleryViewProtocol, router: RouterProtocol) {
        self.viewController = viewController
        self.router = router
        fetchItems()

    }
    
    // MARK: - Protocol logics
    func showDetails(indexPath: IndexPath) {
        let cellModel = items[indexPath.row]
        let detailsModel = DetailsViewModel(id: cellModel.id,
                                            imageURL: cellModel.largeImageURL)
        router?.showDetail(model: detailsModel)
    }
    
    func fetchItems() {

        NetworkManager.dataTask(.items(1, "blue")) { data, response, error in
            if let data = data, let httpResponse = response as? HTTPURLResponse,
                let date = httpResponse.value(forHTTPHeaderField: "Date") {
                print("response date: \(date)")
                if let dataJson = try? JSONDecoder().decode(JsonModel.Model.self, from: data) {
                    let items = dataJson.items.map{ item in
                        GalleryCellModel(id: item.id,
                                         webformatURL: item.webformatURL,
                                         largeImageURL: item.largeImageURL)
                    }
                    self.items.append(contentsOf: items)
                }

            }
        }
        
    }

    
}
