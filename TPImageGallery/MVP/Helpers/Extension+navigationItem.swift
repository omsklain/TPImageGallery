//
//  Extension+navigationItem.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 19.03.2022.
//

import Foundation
import UIKit

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
