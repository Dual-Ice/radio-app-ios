//
//  PopularRouter.swift
//  radio-app-ios
//
//  Created by nik on 10.08.24.
//

import UIKit

final class PopularRouter {
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToDetail(station: Station) {
        navigationController.pushViewController(DetailBuilder.build(navigationController, station), animated: true)
    }
}
