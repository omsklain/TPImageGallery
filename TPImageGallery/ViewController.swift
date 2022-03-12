//
//  ViewController.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 15.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var refreshControl = UIRefreshControl()

    var presenter = Presenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        if presenter.items.count <= 20 {
            presenter.fetchItems { [unowned self] in
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    
    }
    
    private func setupCollectionView () {
        refreshControl.addTarget(self, action: #selector(refreshCollection), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.prefetchDataSource = self
        
        cellRegistration(collectionView: collectionView)

        
    }
    
    @objc private func refreshCollection() {
        presenter.reload { [unowned self] in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }

}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    private func cellRegistration (collectionView: UICollectionView) {
        let nib = UINib(nibName: CollectionViewCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.items.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
        let item = presenter.items[indexPath.item]
        //DispatchQueue.main.async {
            cell.configure(item: item)
        //}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = presenter.items[indexPath.item]
        self.performSegue(withIdentifier: "detailsView", sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsView" {
            guard let destinationVC = segue.destination as? DetailsViewController, let itemSender = sender as? Item else { return }
            
            DispatchQueue.main.async {
                destinationVC.configure(item: itemSender)
            }

        }
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
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

//MARK: - UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offesetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//
//        if offesetY > ( contentHeight - scrollView.frame.height ) - (scrollView.frame.height) {
//            if !self.presenter.isFetching {
//                self.presenter.isFetching = true
//                let oldCountItems = self.presenter.items.count
//
//                self.presenter.isFetching = false
//            }
//        }
//    }
//
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//
//    }
    
}

// MARK: - UICollectionViewDataSourcePrefetching
extension ViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row >= self.presenter.items.count - 1 {
                let oldCountItems = self.presenter.items.count
                self.presenter.appendItemsNextPage { [unowned self] in
                    var indexPaths: [IndexPath] = []
                    for index in oldCountItems ... self.presenter.items.count - 1 {
                        let indexPath = IndexPath(row:  index, section: 0)
                        indexPaths.append(indexPath)
                    }
                    DispatchQueue.main.async {
                        self.collectionView?.performBatchUpdates({
                            self.collectionView?.insertItems(at: indexPaths)
                        }, completion: nil)
                    }
                }
            }
        }
    }
    
    
}
