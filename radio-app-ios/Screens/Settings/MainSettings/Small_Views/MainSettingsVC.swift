//
//  Lang.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

    // MARK: MainSettingsVC Protocol

protocol MainSettingsVCProtocol: AnyObject {
    func restartApp()
}

    // MARK: MainSettingsVC

final class MainSettingsVC: UIViewController, MainSettingsVCProtocol {

    var presenter: MainSettingsPresenter!

    // MARK: UI Elements

    private let settingsView = MainSettingsView()


    // MARK: Life Cycle

    override func loadView() {
        view = settingsView
    }

    override func viewDidLoad() {
        setDelegate()

        callNotificationClosure()
        callLanguageClosure()
        callPolicyClosure()
        callAboutClosure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.setNavigationBar(for: self, title: "Settings")
    }

    // MARK: Private Methods

    private func setDelegate() {
        settingsView.delegate = self
    }
    
    func restartApp() {
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    }
}

    // MARK: Business Logic

extension MainSettingsVC: MainSettingsViewDelegate {

    func editButtonTappedTransfer() {
        presenter.showEditProfileVC()
    }
    
    func logOutButtonTapped() {
        presenter.logOut()
    }
}

extension MainSettingsVC {

    func callNotificationClosure() {
        settingsView.notificationClosureCall = { [weak self] in
            self?.presenter.showNotificationsVC()
        }
    }

    func callLanguageClosure() {
        settingsView.languageClosureCall = { [weak self] in
            self?.presenter.showLanguagesVC()
        }
    }

    func callPolicyClosure() {
        settingsView.policyClosureCall = { [weak self] in
            self?.presenter.showPolicyVC()
        }
    }

    func callAboutClosure() {
        settingsView.aboutClosureCall = { [weak self] in
            self?.presenter.showAboutVC()
        }
    }
}
