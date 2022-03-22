//
//  ScreenBuilder.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 21.03.2022.
//

import UIKit

protocol ScreenBuilderProtocol {
    func buildGalleryScreen(router: RouterProtocol) -> UIViewController
    func buildDetailsScreen(model: DetailsViewModel) -> UIViewController
}

// MARK: - Class
class ScreenBuilder { }

// MARK: - ScreenBuilderProtocol
extension ScreenBuilder: ScreenBuilderProtocol {
    
    func buildGalleryScreen(router: RouterProtocol) -> UIViewController {
        let viewController = GalleryViewController()
        let presenter = GalleryPresenter(viewController: viewController, router: router)
        viewController.presenter = presenter
        
        return viewController
    }
    
    func buildDetailsScreen(model: DetailsViewModel) -> UIViewController {
        let viewController = DetailsViewController()
        let presenter = DetailsPresenter(viewController: viewController, model: model)
        viewController.presenter = presenter
        
        return viewController
    }
    
    
}
