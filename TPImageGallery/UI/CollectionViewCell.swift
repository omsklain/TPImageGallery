//
//  CollectionViewCell.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 15.02.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    static var reuseIdentifier: String { return String(describing: Self.self) }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var downloads: UILabel!
    @IBOutlet weak var likes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 6
        
    }
    
    func configure (item: Item) {
        self.views.text = "\(item.views)"
        self.downloads.text = "\(item.downloads)"
        self.likes.text = "\(item.likes)"
    }

    
}
