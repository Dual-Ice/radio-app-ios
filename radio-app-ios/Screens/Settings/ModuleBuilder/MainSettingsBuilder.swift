//
//  ProfileBuilder.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 08.08.2024.
//

import UIKit

protocol MainSettingsBuilderProtocol {
    func createMainSettingsModule(router: MainSettingsRouter) -> UIViewController
    func createEditProfileVC() -> UIViewController
    func createNotificationsVC() -> UIViewController
    func createLanguageVC() -> UIViewController
    func createAboutVC() -> UIViewController
    func createPolicyVC() -> UIViewController
}

final class MainSettingsBuilder: MainSettingsBuilderProtocol {

    func createMainSettingsModule(router: MainSettingsRouter) -> UIViewController {
        let view = MainSettingsVC()
        let presenter = MainSettingsPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }

    func createEditProfileVC() -> UIViewController {
        let view = EditProfileVC()
        let presenter = EditProfilePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createNotificationsVC() -> UIViewController {
        let view = NotificationsVC()
        let presenter = NotificationsPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createLanguageVC() -> UIViewController {
        let view = LanguageVC()
        let presenter = LanguagePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createAboutVC() -> UIViewController {
        let view = AboutVC()
        let presenter = AboutPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createPolicyVC() -> UIViewController {
        let view = PolicyVC()
        let presenter = PolicyPresenter(view: view)
        view.presenter = presenter
        return view
    }
    


}
