//
//  ProfileBuilder.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 08.08.2024.
//

import UIKit

protocol SettingsBuilderProtocol {
//    func createSettingsModule(router: SettingsRouter) -> UIViewController
    func createProfileVC() -> UIViewController
    func createNotificationsVC() -> UIViewController
    func createLanguageVC() -> UIViewController
    func createAboutVC() -> UIViewController
    func createPolicyVC() -> UIViewController
}

final class SettingsBuilder: SettingsBuilderProtocol {

    func createProfileVC() -> UIViewController {
        UIViewController()
    }
    
    func createNotificationsVC() -> UIViewController {
        UIViewController()
    }
    
    func createLanguageVC() -> UIViewController {
        let view = LanguageVC()
        let presenter = LanguagePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createAboutVC() -> UIViewController {
        UIViewController()
    }
    
    func createPolicyVC() -> UIViewController {
        UIViewController()
    }
    


}
