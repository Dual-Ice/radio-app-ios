//
//  MainSettingsPresenter.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 08.08.2024.
//

import UIKit

    // MARK: MainSettingsPresenter Protocol

protocol MainSettingsPresenterProtocol {
    init(view: MainSettingsVCProtocol, router: MainSettingsRouter)
    func showEditProfileVC()
    func showNotificationsVC()
    func showLanguagesVC()
    func showPolicyVC()
    func showAboutVC()

    func setUserInfo()
    func logOut()
}

    // MARK: MainSettingsPresenter

final class MainSettingsPresenter: MainSettingsPresenterProtocol {

    private weak var view: MainSettingsVCProtocol?
    private var router: MainSettingsRouter

    init(view: MainSettingsVCProtocol,
         router: MainSettingsRouter) {
        self.view = view
        self.router = router
    }
    
    func showEditProfileVC() {
        router.showEditVC()
    }
    
    func showNotificationsVC() {
        router.showNotificationsVC()
    }
    
    func showLanguagesVC() {
        router.showLanguagesVC()
    }
    
    func showPolicyVC() {
        router.showPolicyVC()
    }
    
    func showAboutVC() {
        router.showAboutVC()
    }
    
    func setUserInfo() {
        print ("set user info")
    }

    func logOut() {
        print ("log out button tapped")
    }

}
