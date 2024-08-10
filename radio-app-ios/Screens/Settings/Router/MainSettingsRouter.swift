//
//  MainSettingsRouter.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 08.08.2024.
//

import UIKit

    // MARK: Main Protocol

protocol RouterProtocol {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: MainSettingsBuilderProtocol? { get set }

}

    // MARK: MainSettings Protocol

protocol MainSettingsRouterProtocol: RouterProtocol {
    func initialViewController()
    func showEditVC()
    func showNotificationsVC()
    func showLanguagesVC()
    func showPolicyVC()
    func showAboutVC()
}

final class MainSettingsRouter: MainSettingsRouterProtocol {

    var navigationController: UINavigationController?
    var moduleBuilder: MainSettingsBuilderProtocol?

    init(
        navigationController: UINavigationController,
         moduleBuilder: MainSettingsBuilderProtocol)
    {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainSettingsVC = moduleBuilder?.createMainSettingsModule(router: self) else { return }
            navigationController.viewControllers = [mainSettingsVC]
        }
    }
    
    func showEditVC() {
        if let navigationController = navigationController {
            guard let editProfileVC = moduleBuilder?.createEditProfileVC() else { return }
            navigationController.pushViewController(editProfileVC, animated: true)
        }
    }
    
    func showNotificationsVC() {
        if let navigationController = navigationController {
            guard let notificationsVC = moduleBuilder?.createNotificationsVC() else { return }
            navigationController.pushViewController(notificationsVC, animated: true)
        }
    }
    
    func showLanguagesVC() {
        if let navigationController = navigationController {
            guard let languageVC = moduleBuilder?.createLanguageVC() else { return }
            navigationController.pushViewController(languageVC, animated: true)
        }
    }
    
    func showPolicyVC() {
        if let navigationController = navigationController {
            guard let policyVC = moduleBuilder?.createPolicyVC() else { return }
            navigationController.pushViewController(policyVC, animated: true)
        }
    }
    
    func showAboutVC() {
        if let navigationController = navigationController {
            guard let aboutVC = moduleBuilder?.createAboutVC() else { return }
            navigationController.pushViewController(aboutVC, animated: true)
        }
    }
}
