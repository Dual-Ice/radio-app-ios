//
//  Profile.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

final class NotificationsVC: UIViewController {

    // MARK: UI Elements

    private let notificationView = NotificationsView()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setupConstraints()
    }
}

    // MARK: Layout

private extension NotificationsVC {

    func setView() {
        view.addSubview(notificationView)
        notificationView.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            notificationView.topAnchor.constraint(equalTo: view.topAnchor),
            notificationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notificationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notificationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])

    }

    enum LayoutConstants {

    }
}
