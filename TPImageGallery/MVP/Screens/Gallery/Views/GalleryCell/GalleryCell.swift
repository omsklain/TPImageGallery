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
        imageView.image = nil
        
        // TODO: - refactoring  -  ПЕРЕНОС КОДА?
        NetworkManager.dataTask(.image(model.webformatURL)) { [unowned self] data, response, error in
            if error == nil, let data = data {
                if let image = UIImage(data: data),
                   let httpResponse = response as? HTTPURLResponse,
                   let date = httpResponse.value(forHTTPHeaderField: "Date") {
                    DispatchQueue.main.async {
                        if self.cellId == model.id {
                            self.idLabel.text = String(model.id)
                            self.date.text = date //date.toStringFormat("dd:MM:YYYY HH:mm:ss")
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
