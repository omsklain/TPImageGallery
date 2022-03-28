//
//  DetailsPresenter.swift
//  TPImageGallery
//
//  Created by Константин Туголуков on 19.03.2022.
//

import Foundation
import UIKit

protocol DetailsPresenterProtocol {
    func upDateData()
}

class DetailsPresenter {
    
    // MARK: - External vars
    weak var viewController: DetailsViewProtocol?
    var model: DetailsViewModel?
    
    required init(viewController: DetailsViewProtocol, model: DetailsViewModel) {
        self.viewController = viewController
        self.model = model
    }
    
}

// MARK: - MainPresenterProtocol
extension DetailsPresenter: DetailsPresenterProtocol {
    
    func upDateData() {
        guard let model = self.model else { return }
        viewController?.setNavigationTitle(title: String(model.id))
        
        // TODO: - Возможно перенос?
        DataSourceManager.shared.fetch(model.imageURL) { [weak self] data, error in
            guard let self = self else { return }
            if error == nil, let data = data, let image = UIImage(data: data.data) {
                DispatchQueue.main.async {
                    self.viewController?.setNavigationSubTitle(subTitle: data.date.toStringFormat("dd.MM.YYYY HH:mm:ss"))
                    self.viewController?.setImage(image)
                }
            }
        }
    }
    
}
