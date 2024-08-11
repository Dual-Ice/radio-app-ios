//
//  DetailBuilder.swift
//  radio-app-ios
//
//  Created by Maksim on 01.08.2024.
//

import UIKit

class DetailBuilder {
    static func build(_ navigationController: UINavigationController, _ data: Station) -> UIViewController {
        let router = DetailRouter(navigationVC: navigationController)
        let presenter = DetailPresenter(data: data, router: router)
        let vc = DetailController(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
