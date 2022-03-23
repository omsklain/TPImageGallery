//
//  DetailsViewController.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 19.03.2022.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    func setData( model: DetailsViewModel)
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
    
    func setData( model: DetailsViewModel) {

        indicator.isHidden = false
        indicator.startAnimating()

        // TODO: - refactoring (Подзависает при переходе)
        guard let url = URL(string: model.imageURL) else { return }
        MDCachedData.shared.fetchDataByUrl(url.absoluteString) { [unowned self] data, error in
            if error == nil, let data = data {
                guard let decodeData = try? JSONDecoder().decode(MDCachedData.DataItem.self, from: data) else { return }
                if let image = UIImage(data: decodeData.data) {
                    DispatchQueue.main.async {
                        self.navigationItem.title = String(model.id)
                        self.navigationItem.setSubTitle(decodeData.date.toStringFormat("dd:MM:YYYY HH:mm:ss"))
                        self.imageView.image = image

                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                    }
                }
            }
        }

    }
    
    
}
