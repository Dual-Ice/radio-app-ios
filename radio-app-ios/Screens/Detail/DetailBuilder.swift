//
//  DetailBuilder.swift
//  radio-app-ios
//
//  Created by Maksim on 01.08.2024.
//

import UIKit


protocol DetailBuilderProtocol: AnyObject {
    func build(data: Station) -> UIViewController
}

class DetailBuilder {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func build(data: Station) -> UIViewController {
        let presenter = DetailPresenter(
            data: data,
            router: DetailRouter(navigationVC: navigationController)
        )
        let vc = DetailController(presenter: presenter)
        presenter.view = vc
        return vc
    }
}


