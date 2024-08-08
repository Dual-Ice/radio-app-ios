//
//  About.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

final class AboutVC: UIViewController {

    // MARK: UI Elements

    private let aboutView = AboutView()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setupConstraints()
    }
}

    // MARK: Layout

private extension AboutVC {

    func setView() {
        view.addSubview(aboutView)
        aboutView.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            aboutView.topAnchor.constraint(equalTo: view.topAnchor),
            aboutView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboutView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aboutView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])

    }

    enum LayoutConstants {

    }
}
