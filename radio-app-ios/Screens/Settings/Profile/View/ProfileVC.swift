//
//  Profile.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

final class ProfileVC: UIViewController {

    // MARK: UI Elements

    private let profileView = ProfileView()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setupConstraints()
    }
}

    // MARK: Layout

private extension ProfileVC {

    func setView() {
        view.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupConstraints() {
        
        NSLayoutConstraint.activate([

            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])

    }

    enum LayoutConstants {
        
    }
}
