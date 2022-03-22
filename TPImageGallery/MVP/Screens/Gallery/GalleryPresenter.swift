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
    func showDetails(model: DetailsViewModel)
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
    func showDetails(model: DetailsViewModel) {
        router?.showDetail(model: model)
    }
    
    func fetchItems() {

        let url = "https://pixabay.com/api/?key=25724093-3271289b67930f6caed039a98&q=red&image_type=photo&page=1&per_page=20"
        MDCachedData.shared.fetchDataByUrl(url) { [unowned self] data, error in
            if error == nil, let data = data {
                do {
                    if  let decodeData = try? JSONDecoder().decode(MDCachedData.DataItem.self, from: data) {
                        let dataJson = try JSONDecoder().decode(JsonModel.Model.self, from: decodeData.data)
                        let items = dataJson.items.map{ item in
                            GalleryCellModel(img: UIImage(), imageURL: item.webformatURL, loadDate: Date())
                        }
                        self.items.append(contentsOf: items)
                        //viewController?.setSubTitle(subTitle: "items: \(self.items.count)")
                    }
                } catch  {
                    print("JSONDecoder:error: \(error)")
                }
            }
        }
        
    }
    
    
}
