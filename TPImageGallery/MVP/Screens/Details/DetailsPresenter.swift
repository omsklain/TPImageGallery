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

// MARK: - Class
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
        viewController?.setData(model: model)
    }

}
