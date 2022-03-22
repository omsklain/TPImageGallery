//
//  SceneDelegate.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 15.02.2022.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
//        if let navigationController = window?.rootViewController as? UINavigationController,
//           let rootViewController = navigationController.topViewController as? GalleryViewController {
//            let screenBuilder = ScreenBuilder()
//            let router = Router(navigationController: navigationController, screenBuilder: screenBuilder)
//            let presenter = GalleryPresenter(viewController: rootViewController, router: router)
//            rootViewController.presenter = presenter
//        }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        
        let screenBuilder = ScreenBuilder()
        let router = Router(navigationController: navigationController, screenBuilder: screenBuilder)
        router.initialViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
    }
    
    
}

