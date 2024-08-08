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

    var presenter: MainSettingsPresenter!

    // MARK: UI Elements

    private let settingsView = MainSettingsView()

    // MARK: Life Cycle

    override func viewDidLoad() {
        setView()
        setupConstraints()
    }
}

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
