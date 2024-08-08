//
//  ProfileView.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 07.08.2024.
//

import UIKit

final class NotificationsView: UIView {

    // MARK: UI Elements

    private let backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = Image.signInBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = Color.borderColor.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel = UILabel.makeCustomLabel(
        key: "NotificationsTitle",
        fontSize: 14,
        textColor: .systemGray,
        numberOfLines: 1,
        textAligment: .left)

    #warning("needed medium font")
    private let showNotificationsLabel = UILabel.makeCustomLabelBold(
        key: "ShowNotifications",
        fontSize: 16,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left)

    private let sendNotificationsLabel = UILabel.makeCustomLabelBold(
        key: "SendNotificationsLabel",
        fontSize: 16,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left)

    private let toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = true
        toggle.onTintColor = Color.customLightBlue
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()

    private let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.backgroundColor = .black
        picker.tintColor = .white
        picker.layer.cornerRadius = 10
        picker.layer.borderColor = UIColor.white.cgColor
        picker.layer.borderWidth = 1
        picker.locale = Locale(identifier: "en_GB")
        picker.clipsToBounds = true
        picker.overrideUserInterfaceStyle = .dark
//        picker.isEnabled = false
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setupContraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: Layout

private extension NotificationsView {

    func setView() {
        self.addSubview(backgroundView)
        backgroundView.addSubview(mainView)
        [titleLabel, showNotificationsLabel, sendNotificationsLabel, toggle, timePicker].forEach { mainView.addSubview($0) }
    }

    func setupContraints() {

        NSLayoutConstraint.activate([

            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            mainView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 100),
            mainView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: LayoutConstants.sideOffset),
            mainView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -LayoutConstants.sideOffset),
            mainView.heightAnchor.constraint(equalToConstant: 200),

            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: LayoutConstants.verticalOffset),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: LayoutConstants.sideOffset),

            showNotificationsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutConstants.verticalOffset),
            showNotificationsLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: LayoutConstants.sideOffset),

            sendNotificationsLabel.topAnchor.constraint(equalTo: showNotificationsLabel.bottomAnchor, constant: LayoutConstants.verticalOffset),
            sendNotificationsLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: LayoutConstants.sideOffset),

            toggle.centerYAnchor.constraint(equalTo: showNotificationsLabel.centerYAnchor),
            toggle.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -LayoutConstants.sideOffset),

            timePicker.centerYAnchor.constraint(equalTo: sendNotificationsLabel.centerYAnchor),
            timePicker.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -LayoutConstants.sideOffset),
        ])

    }

    enum LayoutConstants {
        static let verticalOffset: CGFloat = 36
        static let sideOffset: CGFloat = 16
    }
}
