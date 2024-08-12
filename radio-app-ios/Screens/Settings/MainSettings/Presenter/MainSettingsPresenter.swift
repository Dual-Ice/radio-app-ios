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

    func logOut()
}

    // MARK: MainSettingsPresenter

final class MainSettingsPresenter: MainSettingsPresenterProtocol {

    private weak var view: MainSettingsVCProtocol?
    private var router: MainSettingsRouter
    private let authManager = AuthManager()
    private let userManager = UserManager.shared

    init(view: MainSettingsVCProtocol,
         router: MainSettingsRouter) {
        self.view = view
        self.router = router
    }

    func getUserData() -> UserData {
        return userManager.getUserProfileData()
    }

    /// navigation
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

    func logOut() {
        AudioPleer.shared.pauseMusic()
        authManager.signOut { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            UserDefaults.standard.set(false, forKey: "isWelcomeCompleted")
            self.view?.restartApp()
        }
    }

}
