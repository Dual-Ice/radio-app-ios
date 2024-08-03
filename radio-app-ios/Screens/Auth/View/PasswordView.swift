//
//  PasswordView.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 31.07.2024.
//

import UIKit

enum PasswordPageType: String {
    case requestPassword
    case changePassword
}

protocol PasswordViewDelegate: AnyObject {
    func tappedButton(_ sender: UIButton)
}

final class PasswordView: UIView {
    weak var delegate: PasswordViewDelegate?
    
    // MARK: - Public Properties
        
    public var passwordPageType: PasswordPageType? = .requestPassword // delete the value after setting the navigation
    
    // MARK: - UI

    private let bgImage = UIImageView.makeSimpleImage(imageName: "signInBackground")
    
    private var triangleImage = UIImageView.makeSimpleImage(imageName: "trianglePink")
        
    private let headingLabel = UILabel.makeCustomLabelBold(
        key: "ForgotHeading",
        fontSize: Constants.headingSize,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .left)
    
    private let emailField = FormField(labelText: "EmailLabel", placeholder: "YourEmail", isSecure: false)
    private let passwordField = FormField(labelText: "PasswordLabel", placeholder: "YourPassword", isSecure: true)
    private let confirmPasswordField = FormField(labelText: "ConfirmPassword", placeholder: "YourPassword", isSecure: true)
    
    private let inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.topOffset * 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let button = UIButton.makeBigButtonWithTitle(title: "SentButton")
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegates(_ value: PasswordController) {
        delegate = value
    }
    
    // MARK: - Set Views
    
    private func setViews() {
        switch passwordPageType {
            case .requestPassword:
                button.setTitle(NSLocalizedString("SentButton", comment: "Localizable"), for: .normal)
                bgImage.image = nil
                passwordField.isHidden = true
                confirmPasswordField.isHidden = true
            case .changePassword:
                button.setTitle(NSLocalizedString("ChangeButton", comment: "Localizable"), for: .normal)
                emailField.isHidden = true
            default: break
        }
        
        self.backgroundColor = Color.backgroundBlue
        
        self.addSubview(bgImage)
    
        [
            headingLabel,
            triangleImage,
            inputStackView,
            button
        ].forEach { bgImage.addSubview($0) }
        
        [
            emailField,
            passwordField,
            confirmPasswordField
        ].forEach { inputStackView.addArrangedSubview($0) }
        
        setUpViews()
    }
    
    private func setUpViews(){
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    @objc private func buttonTapped(_ sender: UIButton){
        delegate?.tappedButton(sender)
    }
    
    // MARK: - Setup Constraints
    
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: self.topAnchor),
            bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bgImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bgImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            triangleImage.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topOffset * 8),
            triangleImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            headingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topOffset * 19),
            headingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            inputStackView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: Constants.customOffset),
            inputStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            inputStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.customOffset),
            
            button.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: Constants.topOffset * 5),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.customOffset),
            button.heightAnchor.constraint(equalToConstant: Constants.bigButtonHeight)
        ])
    }
    
    private func configureUI() {
        switch passwordPageType {
            case .requestPassword:
                button.setTitle(NSLocalizedString("SentButton", comment: "Localizable"), for: .normal)
                emailField.isHidden = false
                passwordField.isHidden = true
                confirmPasswordField.isHidden = true
            case .changePassword:
                button.setTitle(NSLocalizedString("ChangeButton", comment: "Localizable"), for: .normal)
                emailField.isHidden = true
                passwordField.isHidden = false
                confirmPasswordField.isHidden = false
            default: break
        }
    }
}


