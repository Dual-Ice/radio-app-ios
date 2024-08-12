//
//  ProfileView.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 07.08.2024.
//

import UIKit

    // MARK: EditProfile View

final class EditProfileView: UIView {

    // MARK: UI Elements

    private let backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = Image.signInBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var userImage: UIImageView = {
        let image = UIImageView()
        image.image = Image.userMock
        image.layer.cornerRadius = LayoutConstants.userImageSize / 2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let editButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.editCircle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var userName = UILabel.makeCustomLabelBold(
        key: "HeaderUserName",
        fontSize: 16,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .center)

    private var userEmail = UILabel.makeCustomLabel(
        key: "HeaderUserEmail",
        fontSize: 14,
        textColor: .systemGray,
        numberOfLines: 1,
        textAligment: .center)

    private let textFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 25
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let changeNameTextfield = UITextField.makeCustomPinkTextfield(
        placeholderText: "UserName",
        isSecure: false,
        keyboardType: .default)

    private let changeEmailTextfield = UITextField.makeCustomPinkTextfield(
        placeholderText: "UserEmail",
        isSecure: false,
        keyboardType: .emailAddress)

    private let errorLabel = UILabel.makeCustomLabel(
        key: "ChangeEmailError",
        fontSize: 12,
        textColor: .systemRed,
        numberOfLines: 1,
        textAligment: .left)

    private let changePasswordTextfield = UITextField.makeCustomPinkTextfield(
        placeholderText: "Password",
        isSecure: false,
        keyboardType: .default)

    private let saveButton = UIButton.makeBigButtonWithTitle(title: "Save Changes")

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

private extension EditProfileView {

    func setView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backgroundView)
        [userImage, userName, userEmail, editButton, textFieldStackView, saveButton, errorLabel].forEach { backgroundView.addSubview($0) }
        [changeNameTextfield, changeEmailTextfield, changePasswordTextfield].forEach { textFieldStackView.addArrangedSubview($0) }
    }

    func setupContraints() {
       
        NSLayoutConstraint.activate([

            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            userImage.heightAnchor.constraint(equalToConstant: LayoutConstants.userImageSize),
            userImage.widthAnchor.constraint(equalToConstant: LayoutConstants.userImageSize),
            userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            userImage.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),

            userName.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: LayoutConstants.verticalOffset),
            userName.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),

            userEmail.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: LayoutConstants.smallVerticalOffset),
            userEmail.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),

            editButton.centerYAnchor.constraint(equalTo: userImage.centerYAnchor, constant: 24),
            editButton.centerXAnchor.constraint(equalTo: userImage.centerXAnchor, constant: 24),

            textFieldStackView.topAnchor.constraint(equalTo: userEmail.bottomAnchor, constant: LayoutConstants.bigVerticalOffset),
            textFieldStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: LayoutConstants.sideOffset),
            textFieldStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -LayoutConstants.sideOffset),

            changeNameTextfield.heightAnchor.constraint(equalToConstant: LayoutConstants.stackElementSize),
            changeEmailTextfield.heightAnchor.constraint(equalToConstant: LayoutConstants.stackElementSize),
            changePasswordTextfield.heightAnchor.constraint(equalToConstant: LayoutConstants.stackElementSize),
            
            saveButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: LayoutConstants.bigVerticalOffset),
            saveButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: LayoutConstants.sideOffset),
            saveButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -LayoutConstants.sideOffset),
            saveButton.heightAnchor.constraint(equalToConstant: LayoutConstants.stackElementSize),

            errorLabel.leadingAnchor.constraint(equalTo: changeEmailTextfield.leadingAnchor, constant: 10),
            errorLabel.topAnchor.constraint(equalTo: changeEmailTextfield.bottomAnchor, constant: 4),

        ])
    }

    enum LayoutConstants {
        static let userImageSize: CGFloat = 72
        static let editButtonSize: CGFloat = 32
        static let stackElementSize: CGFloat = 56

        static let sideOffset: CGFloat = 32
        static let verticalOffset: CGFloat = 12
        static let bigVerticalOffset: CGFloat = 36
        static let smallVerticalOffset: CGFloat = 6

    }
}
