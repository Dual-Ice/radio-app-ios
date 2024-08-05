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

        [backgroundView, stackView].forEach { self.addSubview($0) }
        [userInfoView, generalSettingsView, moreSettingsView].forEach { stackView.addArrangedSubview($0) }
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),

            userInfoView.heightAnchor.constraint(equalToConstant: 100),
            generalSettingsView.heightAnchor.constraint(equalToConstant: 170),
            moreSettingsView.heightAnchor.constraint(equalToConstant: 170),

        ])
    }
}
