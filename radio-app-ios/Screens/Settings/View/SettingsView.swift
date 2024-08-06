//
//  LanguagesView.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 04.08.2024.
//

import UIKit

final class SettingsView: UIView {

    // MARK: UI Elements

    private let backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = Image.signInBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let userInfoView = UserInfoView()
    private let generalSettingsView = GeneralSettingsView()
    private let moreSettingsView = MoreSettingsView()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let logoutButton = UIButton.makeBigButtonWithTitle(title: "Log Out")

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingsView {

    func setView() {
        self.translatesAutoresizingMaskIntoConstraints = false

        [backgroundView, stackView, logoutButton].forEach { self.addSubview($0) }
        [userInfoView, generalSettingsView, moreSettingsView].forEach { stackView.addArrangedSubview($0) }
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstants.sideOffset),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.sideOffset),

            userInfoView.heightAnchor.constraint(equalToConstant: LayoutConstants.userInfoFieldSize),
            generalSettingsView.heightAnchor.constraint(equalToConstant: LayoutConstants.settingsBigSize),
            moreSettingsView.heightAnchor.constraint(equalToConstant: LayoutConstants.settingsBigSize),

            logoutButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstants.sideOffset),
            logoutButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.sideOffset),
            logoutButton.heightAnchor.constraint(equalToConstant: LayoutConstants.logoutButtonHeight),
            logoutButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: LayoutConstants.sideOffset)

        ])
    }

    enum LayoutConstants {
        static let userInfoFieldSize: CGFloat = 100
        static let settingsBigSize: CGFloat = 170
        static let logoutButtonHeight: CGFloat = 56

        static let sideOffset: CGFloat = 30
    }
}
