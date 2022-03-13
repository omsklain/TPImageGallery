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
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    private var itemId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 6
        
    }
    
    func configure(item: Item?) {
        
        self.id.text = ""
        self.date.text = ""
        self.imageView.image = nil
        
        self.progress.isHidden = false
        self.progress.startAnimating()
        
        if let item = item {
            self.itemId = item.id
            self.id.text = String(item.id)
            guard let url = URL(string: item.webformatURL) else { return }
            MDCachedData.shared.fetchDataByUrl(url.absoluteString) { [unowned self] data, error in
                if error == nil, let data = data {
                    guard let decodeData = try? JSONDecoder().decode(MDCachedData.DataItem.self, from: data) else { return }
                    if let image = UIImage(data: decodeData.data) {
                        DispatchQueue.main.async { [weak self] in
                            if self?.itemId == item.id {
                                self?.date.text = decodeData.date.toStringFormat("d MMMM YYYY HH:mm:ss")
                                self?.imageView.image = image
                            }
                            self?.progress.stopAnimating()
                            self?.progress.isHidden = true
                        }
                    }
                }
            }
        }
    }
    
    
}
