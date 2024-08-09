//
//  LanguagesView.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 04.08.2024.
//

import UIKit

    // MARK: MainSettingsView Delegate

protocol MainSettingsViewDelegate: AnyObject {
    func editButtonTappedTransfer()
    func logOutButtonTapped()
}

    // MARK: MainSettingsView

final class MainSettingsView: UIView {

    // MARK: Properties

    weak var delegate: MainSettingsViewDelegate?
    var notificationClosureCall: (() -> ())?
    var languageClosureCall: (() -> ())?
    var policyClosureCall: (() -> ())?
    var aboutClosureCall: (() -> ())?

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
        setupTargets()
        setupDelegate()

        /// transfer actions between views
        notificationClosureTransfer()
        languageClosureTransfer()
        policyClosureTransfer()
        aboutClosureTransfer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setupDelegate() {
        userInfoView.delegate = self
    }

    private func setupTargets() {
        logoutButton.addTarget(self, action: #selector(logOutButtonAction), for: .touchUpInside)
    }

    // MARK: Selector Methods

    @objc private func logOutButtonAction() {
        delegate?.logOutButtonTapped()
    }
}

    // MARK: Work with Delegate

extension MainSettingsView: UserInfoViewDelegate {
    func editButtonTapped() {
        delegate?.editButtonTappedTransfer()
    }
}

extension MainSettingsView {

    private func notificationClosureTransfer() {
        generalSettingsView.firstViewTap = { [weak self] in
            self?.notificationClosureCall?()
        }
    }

    private func languageClosureTransfer() {
        generalSettingsView.secondViewTap = { [weak self] in
            self?.languageClosureCall?()
        }
    }

    private func policyClosureTransfer() {
        moreSettingsView.firstViewTap = { [weak self] in
            self?.policyClosureCall?()
        }
    }

    private func aboutClosureTransfer() {
        moreSettingsView.secondViewTap = { [weak self] in
            self?.aboutClosureCall?()
        }
    }
}

    // MARK: Layout
private extension MainSettingsView {

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
        static let settingsBigSize: CGFloat = 200
        static let logoutButtonHeight: CGFloat = 56

        static let sideOffset: CGFloat = 30
    }
}
