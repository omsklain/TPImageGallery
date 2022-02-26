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
    }
    
    private func setupCollectionView () {
        refreshControl.addTarget(self, action: #selector(refreshCollection), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        collectionView.delegate = self
        collectionView.dataSource = self
        cellRegistration(collectionView: collectionView)
        
        refreshCollection()
        
    }
    
    @objc private func refreshCollection() {
        let colorsRandom = ["green","red","yellow"].randomElement() ?? "green"
        let typeRandom = ["flowers","auto","space"].randomElement() ?? "flowers"
        let filter = colorsRandom + "+" + typeRandom
        let countRandom = Int.random(in: 50...150)
        
        let url = "https://pixabay.com/api/?key=25724093-3271289b67930f6caed039a98&q=\(filter)&image_type=photo&per_page=\(countRandom)"
        presenter.fetchItems(url) { [unowned self] in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.collectionView.reloadData()
                self.presenter.clearCache()
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
        cell.configure(item: item)
        cell.imageView.image = nil
        
        presenter.loadItem(url: item.webformatURL) { item in
            DispatchQueue.main.async {
                cell.imageView.image = item?.image
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = presenter.items[indexPath.item]
        self.performSegue(withIdentifier: "detailsView", sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsView" {
            guard let destinationVC = segue.destination as? DetailsViewController, let itemSender = sender as? Item else { return }
            presenter.loadItem(url: itemSender.largeImageURL) { item in
                DispatchQueue.main.async {
                    destinationVC.mainTitle = "ID: \(itemSender.id)"
                    destinationVC.subTitle = item?.date.toStringFormat("d MMMM YYYY HH:mm:ss")
                    destinationVC.image = item?.image
                }
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
