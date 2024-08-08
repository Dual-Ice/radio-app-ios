//
//  MainSettingsPresenter.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 08.08.2024.
//

import UIKit

protocol MainSettingsPresenterProtocol {
    init(view: MainSettingsVCProtocol, router: MainSettingsRouter)
    func showEditVC()
    func showNotificationsVC()
    func showLanguagesVC()
    func showPolicyVC()
    func showAboutVC()
}

final class MainSettingsPresenter: MainSettingsPresenterProtocol {

    private weak var view: MainSettingsVCProtocol?
    private var router: MainSettingsRouter

    init(view: MainSettingsVCProtocol,
         router: MainSettingsRouter) {
        self.view = view
        self.router = router
    }
    
    func showEditVC() {
        // code
    }
    
    func showNotificationsVC() {
        // code
    }
    
    func showLanguagesVC() {
        // code
    }
    
    func showPolicyVC() {
        // code
    }
    
    func showAboutVC() {
        // code
    }
    

}
