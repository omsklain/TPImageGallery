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
    
    override func prepareForReuse() {
            super.prepareForReuse()
            //imageView.kf.cancelDownloadTask()
            imageView.image = nil
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
        imageView.image = nil
        
        // TODO: - refactoring  -  ПЕРЕНОС КОДА?
        DataSourceManager.shared.fetch(model.webformatURL) { [weak self] data, error in
            guard let self = self else { return }
            if error == nil, let data = data, let image = UIImage(data: data.data) {
                DispatchQueue.main.async {
                    if self.cellId == model.id {
                        self.idLabel.text = String(model.id)
                        self.date.text = data.date.toStringFormat("dd.MM.YYYY HH:mm:ss")
                        self.imageView.image = image
                    }
                    self.progress.stopAnimating()
                    self.progress.isHidden = true
                }
            }
        }
    }
    
    
}
