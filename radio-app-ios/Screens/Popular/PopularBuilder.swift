//
//  PopularBuilder.swift
//  radio-app-ios
//
//  Created by nik on 10.08.24.
//

import UIKit

final class PopularBuilder {
    static func buildPopularController(_ navigationController: UINavigationController) -> UIViewController {
        let router = PopularRouter(navigationController)
        let presenter = PopularPresenter(popularRoute: router)
        let vc = PopularController(presenter: presenter)
        presenter.popularVC = vc
        
        return vc
    }
}
