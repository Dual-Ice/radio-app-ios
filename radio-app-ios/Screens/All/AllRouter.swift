//
//  AllRouter.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 11.08.2024.
//

import UIKit

final class AllRouter {
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToDetail(station: Station) {
        navigationController.pushViewController(DetailBuilder.build(navigationController, station), animated: true)
    }
    
    func goToSettings() {
        let builder = MainSettingsBuilder()
        let router = MainSettingsRouter(navigationController: navigationController, moduleBuilder: builder)
        let settingsVC = builder.createMainSettingsModule(router: router)
        navigationController.pushViewController(settingsVC, animated: true)
    }
}
