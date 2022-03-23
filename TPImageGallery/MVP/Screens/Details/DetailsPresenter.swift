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
        guard let model = self.model, let url = URL(string: model.imageURL) else { return }
        viewController?.setNavigationTitle(title: String(model.id))
        // TODO: - refactoring -  ПЕРЕНОС КОДА
        MDCachedData.shared.fetchDataByUrl(url.absoluteString) { [unowned self] data, error in
            if error == nil, let data = data {
                guard let decodeData = try? JSONDecoder().decode(MDCachedData.DataItem.self, from: data) else { return }
                if let image = UIImage(data: decodeData.data) {
                    DispatchQueue.main.async {
                        self.viewController?.setNavigationSubTitle(subTitle: decodeData.date.toStringFormat("dd:MM:YYYY HH:mm:ss"))
                        self.viewController?.setImage(image)
                    }
                }
            }
        }
    }

}
