//
//  DetailsViewController.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 15.02.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progress.isHidden = false
        self.progress.startAnimating()
        
    }
    
    func configure(item: Item?) {
        self.navigationItem.title = ""
        self.navigationItem.setSubTitle("")
        
        //self.imageView.image = nil
        
        if let item = item {
            self.navigationItem.title = String(item.id)
            guard let url = URL(string: item.largeImageURL) else { return }
            
            MDCachedData.shared.fetchDataByUrl(url.absoluteString) { [unowned self] data, error in
                if error == nil, let data = data {
                    guard let decodeData = try? JSONDecoder().decode(MDCachedData.DataItem.self, from: data) else { return }
                    if let image = UIImage(data: decodeData.data) {
                        DispatchQueue.main.async { [weak self] in
                            self?.navigationItem.setSubTitle(decodeData.date.toStringFormat("d MMMM YYYY HH:mm:ss"))
                            self?.imageView.image = image
                            self?.progress.stopAnimating()
                            self?.progress.isHidden = true
                        }
                    }
                }
            }
        }
    }
    
}

// MARK: - Custom Title ( title + subtitle)
extension UINavigationItem {
    
    func setSubTitle(_ subTitle: String) {
        let titleLabel = UILabel()
        titleLabel.text = self.title
        
        let subTitleLabel = UILabel()
        subTitleLabel.text = subTitle
        subTitleLabel.font = .systemFont(ofSize: 12.0)
        subTitleLabel.textColor = .gray
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.axis = .vertical
        
        self.titleView = stackView
    }
    
    
}
