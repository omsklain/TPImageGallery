//
//  DetailsViewController.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 19.03.2022.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    func setImage(_ image: UIImage)
    func setNavigationTitle(title:String?)
    func setNavigationSubTitle(subTitle: String?)
}

// MARK: - Class
class DetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var navItem: UINavigationItem!
    
    // MARK: - Internal vars
    
    
    // MARK: - External vars
    var presenter: DetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator.isHidden = false
        indicator.startAnimating()
        
        presenter.upDateData()
        
    }
    
    // MARK: - Internal logics

}

// MARK: - DetailsViewProtocol
extension DetailsViewController: DetailsViewProtocol {
    
    func setImage(_ image: UIImage) {
        imageView.image = image
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    func setNavigationTitle(title: String?) {
        if let title = title {
            navItem.title = title
        }
    }
    
    func setNavigationSubTitle(subTitle: String?) {
        if let subTitle = subTitle {
            navItem.setSubTitle(subTitle)
        }
    }
    
}

// MARK: - UIBarPositioningDelegate
extension DetailsViewController: UIBarPositioningDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
