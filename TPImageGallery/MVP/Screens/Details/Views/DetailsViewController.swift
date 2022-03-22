//
//  DetailsViewController.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 19.03.2022.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    func setData(_ data: DetailsViewModel)
}

// MARK: - Class
class DetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // MARK: - Internal vars
    
    
    // MARK: - External vars
    var presenter: DetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        presenter.upDateData()
    }
    
    // MARK: - Internal logics

}

// MARK: - DetailsViewProtocol
extension DetailsViewController: DetailsViewProtocol {
    
    func setData(_ data: DetailsViewModel) {

        indicator.isHidden = false
        indicator.startAnimating()

        imageView.image = data.img
        
        navigationItem.title = "iD"
        navigationItem.setSubTitle(data.loadDate.toStringFormat("dd:MM:YYYY HH:mm:ss"))
        
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    
}
