//
//  Profile.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

final class LanguageVC: UIViewController {

    // MARK: UI Elements

    private let languageView = LanguageView()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setupConstraints()
    }
}

    // MARK: Layout

private extension LanguageVC {

    func setView() {
        view.addSubview(languageView)
        languageView.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            languageView.topAnchor.constraint(equalTo: view.topAnchor),
            languageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            languageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            languageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])

    }

    enum LayoutConstants {

    }
}
