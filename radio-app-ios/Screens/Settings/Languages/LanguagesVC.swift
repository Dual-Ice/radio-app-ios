//
//  Lang.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

final class LanguagesVC: UIViewController {

    // MARK: UI Elements

    private let backgroundView = LanguagesView()

    // MARK: Life Cycle

    override func viewDidLoad() {
        setView()
        setupConstraints()
    }
}

private extension LanguagesVC {

    func setView() {
        [backgroundView].forEach { view.addSubview($0) }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
