//
//  Router.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 22.03.2022.
//

import UIKit

protocol RouterProtocol {
    func initialViewController()
    func showDetail(model: DetailsViewModel)
    func popToRoot()
}

// MARK: - Class
class Router {
    
    var navigationController: UINavigationController?
    var screenBuilder: ScreenBuilder?
    
    init(navigationController: UINavigationController, screenBuilder: ScreenBuilder) {
        self.navigationController = navigationController
        self.screenBuilder = screenBuilder
    }
    
}

// MARK: - RouterProtocol
extension Router: RouterProtocol {
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = screenBuilder?.buildGalleryScreen(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(model: DetailsViewModel) {
        if let navigationController = navigationController {
            guard let detailsViewController = screenBuilder?.buildDetailsScreen(model: model) else { return }
            navigationController.pushViewController(detailsViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
}
