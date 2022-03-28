//
//  GalleryViewController.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 22.03.2022.
//

import UIKit

protocol GalleryViewProtocol: AnyObject {
    func setSubTitle (subTitle: String)
    func addItems (indexPaths: [IndexPath])
}

class GalleryViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - External vars
    var presenter: GalleryPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Gallery images"
        navigationItem.backButtonTitle = "Back"
        
        setupCollectionView()
        
    }
    
    // MARK: - Internal logics
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: GalleryCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: GalleryCell.reuseIdentifier)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + view.frame.size.height > scrollView.contentSize.height * 0.9 {
            presenter.fetchItems()
        }
    }
    
}

// MARK: - GalleryViewProtocol
extension GalleryViewController: GalleryViewProtocol {
    
    func addItems (indexPaths: [IndexPath]) {
        if presenter.items.count != collectionView.numberOfItems(inSection: 0) {
            collectionView.insertItems(at: indexPaths)
        }
    }
    
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






