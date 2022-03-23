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
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    // MARK: - Internal vars
    private var cellId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayer()
    }
    
    // MARK: - Internal logics
    private func setupLayer() {
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    // MARK: - External logics
    func setup(model: GalleryCellModel) {
        progress.isHidden = false
        progress.startAnimating()
        
        cellId = model.id
        
        // TODO: - refactoring  -  ПЕРЕНОС КОДА?
        guard let url = URL(string: model.webformatURL) else { return }
        MDCachedData.shared.fetchDataByUrl(url.absoluteString) { [unowned self] data, error in
            if error == nil, let data = data {
                guard let decodeData = try? JSONDecoder().decode(MDCachedData.DataItem.self, from: data) else { return }
                if let image = UIImage(data: decodeData.data) {
                    DispatchQueue.main.async {
                        if self.cellId == model.id {
                            self.idLabel.text = String(model.id)
                            self.date.text = decodeData.date.toStringFormat("dd:MM:YYYY HH:mm:ss")
                            self.imageView.image = image
                        }
                        self.progress.stopAnimating()
                        self.progress.isHidden = true
                    }
                }
            }
        }
        
    }
    
    
}
