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

class GalleryPresenter: GalleryPresenterProtocol {
    
    // MARK: - External vars
    var router: RouterProtocol?
    weak var viewController: GalleryViewProtocol?
    var items = [GalleryCellModel]()
    
    // MARK: - Internal vars
    private var isUpdatingItems = false
    private var currentPage = 1
    
    required init(viewController: GalleryViewProtocol, router: RouterProtocol) {
        self.viewController = viewController
        self.router = router
    }
    
    // MARK: - Protocol logics
    func showDetails(indexPath: IndexPath) {
        let cellModel = items[indexPath.row]
        let detailsModel = DetailsViewModel(id: cellModel.id, imageURL: cellModel.largeImageURL)
        router?.showDetail(model: detailsModel)
    }
    
    func fetchItems() {
        if isUpdatingItems { return }
        
        let urlString = "https://pixabay.com/api/?key=25724093-3271289b67930f6caed039a98&q=red&image_type=photo&page=\(currentPage)&per_page=20"
        
        isUpdatingItems = true
        
        DataSourceManager.shared.fetch(urlString) { [weak self] data, error in
            guard let self = self else { return }
            
            if error == nil, let data = data {
                do {
                    let dataJson = try JSONDecoder().decode(JsonModel.Model.self, from: data.data)
                    
                    let items = dataJson.items.map{ item in
                        GalleryCellModel(id: item.id,
                                         webformatURL: item.webformatURL,
                                         largeImageURL: item.largeImageURL)
                    }
                    
                    let lastIndexItems = self.items.count
                    self.items.append(contentsOf: items)
                    let indexPaths = (lastIndexItems..<self.items.count).map { IndexPath(item: $0, section: 0) }
                    
                    self.currentPage += 1
                    self.viewController?.addItems(indexPaths: indexPaths)
                    self.isUpdatingItems = false
                    
                } catch  {
                    print("JSONDecoder:error: \(error)")
                }
            }
        }
    }
    
}
