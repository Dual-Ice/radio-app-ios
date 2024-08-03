//
//  DetailBuilder.swift
//  radio-app-ios
//
//  Created by Maksim on 01.08.2024.
//

import UIKit

class DetailBuilder {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func build(data: Datan) -> UIViewController {
        let presenter = DetailPresenter(data: data)
        let vc = DetailController(presenter: presenter)
        presenter.view = vc
        return vc
    }
}


