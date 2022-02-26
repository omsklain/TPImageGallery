//
//  DetailsViewController.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 15.02.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var mainTitle: String? {
        didSet {
            self.navigationItem.title = mainTitle
        }
    }
    
    var subTitle: String? {
        didSet {
            self.navigationItem.setSubTitle(subTitle ?? "")
        }
    }
    
    var image: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.imageView.image = self.image
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
