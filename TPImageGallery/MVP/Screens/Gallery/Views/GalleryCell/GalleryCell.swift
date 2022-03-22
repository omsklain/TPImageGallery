//
//  GalleryCell.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 15.02.2022.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    static var reuseIdentifier: String { return String(describing: Self.self) }
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    // MARK: - Internal vars
    private var cellId: Int?
    
    // MARK: - External vars
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    // MARK: - Internal logics
    func setup(model: GalleryCellModel?) {
        progress.isHidden = false
        progress.startAnimating()
        
        guard let model = model else {
            // TODO: Set image default
            return
        }
        
        //cellId = data.id
        
        date.text = model.loadDate.toStringFormat("dd:MM:YYYY HH:mm:ss")
        imageView.image = model.img
        
        progress.isHidden = true
        progress.stopAnimating()
    }
    
//    func configure(item: Item?) {
//
//        self.id.text = ""
//        self.date.text = ""
//        self.imageView.image = nil
//
//        self.progress.isHidden = false
//        self.progress.startAnimating()
//
//        if let item = item {
//            self.cellId = item.id
//            self.id.text = String(item.id)
//            guard let url = URL(string: item.webformatURL) else { return }
//            MDCachedData.shared.fetchDataByUrl(url.absoluteString) { [unowned self] data, error in
//                if error == nil, let data = data {
//                    guard let decodeData = try? JSONDecoder().decode(MDCachedData.DataItem.self, from: data) else { return }
//                    if let image = UIImage(data: decodeData.data) {
//                        DispatchQueue.main.async { [weak self] in
//                            if self?.itemId == item.id {
//                                self?.date.text = decodeData.date.toStringFormat("d MMMM YYYY HH:mm:ss")
//                                self?.imageView.image = image
//                            }
//                            self?.progress.stopAnimating()
//                            self?.progress.isHidden = true
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    
}
