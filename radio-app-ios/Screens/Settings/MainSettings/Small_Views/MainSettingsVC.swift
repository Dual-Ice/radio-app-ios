//
//  Lang.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

protocol MainSettingsVCProtocol: AnyObject {

}

final class MainSettingsVC: UIViewController, MainSettingsVCProtocol {

    // MARK: Properties

    var presenter: MainSettingsPresenter!

    // MARK: UI Elements

    private let settingsView = MainSettingsView()

    // MARK: Life Cycle

    override func viewDidLoad() {
        setView()
        setupConstraints()
        setupDelegate()

        callNotificationClosure()
        callLanguageClosure()
        callPolicyClosure()
        callAboutClosure()
    }

    // MARK: Private Methods

    private func setupDelegate() {
        settingsView.delegate = self
    }
}

    // MARK: Business Logic

extension MainSettingsVC: MainSettingsViewDelegate {

    func editButtonTappedTransfer() {
        print ("edit button tapped")
        presenter.showEditProfileVC()
    }
    
    func logOutButtonTapped() {
        print ("log out button tapped")
    }
}

extension MainSettingsVC {

    func callNotificationClosure() {
        settingsView.notificationClosureCall = { [weak self] in
            print ("notification call")
            self?.presenter.showNotificationsVC()
        }
    }

    func callLanguageClosure() {
        settingsView.languageClosureCall = { [weak self] in
            print ("languages call")
            self?.presenter.showLanguagesVC()
        }
    }

    func callPolicyClosure() {
        settingsView.policyClosureCall = { [weak self] in
            print ("policy call")
            self?.presenter.showPolicyVC()
        }
    }

    func callAboutClosure() {
        settingsView.aboutClosureCall = { [weak self] in
            print ("about call")
            self?.presenter.showAboutVC()
        }
    }
}

    // MARK: Layout

private extension MainSettingsVC {

    func setView() {
        [settingsView].forEach { view.addSubview($0) }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
