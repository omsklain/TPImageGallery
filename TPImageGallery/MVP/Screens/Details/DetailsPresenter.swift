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
        viewController?.setNavigationTitle(title: String(model.id))
        
        // TODO: - refactoring -  ПЕРЕНОС КОДА
        NetworkManager.dataTask(.image(model.imageURL)) { data, response, error in
            if error == nil, let data = data {
                if let image = UIImage(data: data),
                   let httpResponse = response as? HTTPURLResponse,
                   let date = httpResponse.value(forHTTPHeaderField: "Date")  {
                    DispatchQueue.main.async {
                        self.viewController?.setNavigationSubTitle(subTitle: date)
                        self.viewController?.setImage(image)
                    }
                }
            }
        }

    }

}
