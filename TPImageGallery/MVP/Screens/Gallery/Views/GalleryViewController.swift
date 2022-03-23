//
//  GalleryViewController.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 22.03.2022.
//

import UIKit

protocol GalleryViewProtocol: AnyObject {
    func setSubTitle (subTitle: String)
}

// MARK: - Class
class GalleryViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Internal vars
    
    
    // MARK: - External vars
    var presenter: GalleryPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Gallery images"
        navigationItem.backButtonTitle = "Back"
        
        setupCollectionView()
        //collectionView.reloadData()
        
        //        if presenter.items.count <= 20 {
        //            presenter.fetchItems { [unowned self] in
        //                DispatchQueue.main.async {
        //                    self.collectionView.reloadData()
        //                }
        //            }
        //        }
        
    }
    
    // MARK: - Internal logics
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        let nib = UINib(nibName: GalleryCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: GalleryCell.reuseIdentifier)
    }
    
}

// MARK: - GalleryViewProtocol
extension GalleryViewController: GalleryViewProtocol {
    
    func setSubTitle (subTitle: String) {
        navigationItem.setSubTitle(subTitle)
    }
    
}

// MARK: - UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.reuseIdentifier, for: indexPath) as! GalleryCell
        let itemModel = presenter.items[indexPath.item]
        cell.setup(model: itemModel)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension GalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showDetails(indexPath: indexPath)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    private var paddingCell: CGFloat { 10 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - (paddingCell * 3)) / 2
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: paddingCell, left: paddingCell, bottom: paddingCell, right: paddingCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return paddingCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return paddingCell
    }
    
}


// MARK: - UICollectionViewDataSourcePrefetching
extension GalleryViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for _ in indexPaths {
            //            if indexPath.row >= self.presenter.items.count - 1 {
            //                let oldCountItems = self.presenter.items.count
            //                self.presenter.appendItemsNextPage { [unowned self] in
            //                    var indexPaths: [IndexPath] = []
            //                    for index in oldCountItems ... self.presenter.items.count - 1 {
            //                        let indexPath = IndexPath(row:  index, section: 0)
            //                        indexPaths.append(indexPath)
            //                    }
            //                    DispatchQueue.main.async {
            //                        self.collectionView?.performBatchUpdates({
            //                            self.collectionView?.insertItems(at: indexPaths)
            //                        }, completion: nil)
            //                    }
            //                }
            //            }
        }
    }
    
}



