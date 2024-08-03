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
        
    public var passwordPageType: PasswordPageType? = .changePassword // delete the value after setting the navigation
    
    // MARK: - UI

    private let bgImage = UIImageView.makeSimpleImage(imageName: "signInBackground")
    
    private var triangleImage = UIImageView.makeSimpleImage(imageName: "trianglePink")
        
    private let headingLabel = UILabel.makeCustomLabelBold(
        key: "ForgotHeading",
        fontSize: Constants.headingSize,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .center)
    
    private let emailLabel = UILabel.makeCustomLabel(
        key: "EmailLabel",
        fontSize: Constants.regularLabelSize,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .left)
        
    private let emailTexfield = UITextField.makeCustomPinkTextfield(placeholderText: "YourEmail")
    
    private let passwordLabel = UILabel.makeCustomLabel(
        key: "PasswordLabel",
        fontSize: Constants.regularLabelSize,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .left)
    
    private let passwordTexfield = UITextField.makePasswordPinkTextfield(placeholderText: "YourPassword")
    
    private let confirmLabel = UILabel.makeCustomLabel(
        key: "ConfirmPassword",
        fontSize: Constants.regularLabelSize,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .left)
    
    private let confirmTexfield = UITextField.makePasswordPinkTextfield(placeholderText: "YourPassword")
    
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
                passwordLabel.isHidden = true
                passwordTexfield.isHidden = true
                confirmLabel.isHidden = true
                confirmTexfield.isHidden = true
            case .changePassword:
                button.setTitle(NSLocalizedString("ChangeButton", comment: "Localizable"), for: .normal)
                emailLabel.isHidden = true
                emailTexfield.isHidden = true
            default: break
        }
        
        self.backgroundColor = Color.backgroundBlue
        headingLabel.textAlignment = .left
        
        self.addSubview(bgImage)
    
        [
            headingLabel,
            triangleImage,
            emailLabel,
            emailTexfield,
            passwordLabel,
            passwordTexfield,
            confirmLabel,
            confirmTexfield,
            button
        ].forEach { bgImage.addSubview($0) }
        
        setUpViews()
    }
    
    private func setUpViews(){
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    @objc private func buttonTapped(_ sender: UIButton){
        delegate?.tappedButton(sender)
    }
    
    // MARK: - Setup Constraints
    
    
    private func setCommonLayouts() {
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: self.topAnchor),
            bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bgImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bgImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            triangleImage.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topOffset * 8),
            triangleImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            headingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topOffset * 19),
            headingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.customOffset),
            button.heightAnchor.constraint(equalToConstant: Constants.bigButtonHeight)
        ])
    }
    
    private func setRequestLayouts(){
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: Constants.topOffset * 4),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            emailTexfield.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Constants.topOffset),
            emailTexfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            emailTexfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.customOffset),
            emailTexfield.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            
            button.topAnchor.constraint(equalTo: emailTexfield.bottomAnchor, constant: Constants.topOffset * 8)
        ])
    }
    
    private func setChangePasswordLayouts(){
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: Constants.topOffset * 4),
            passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            passwordTexfield.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: Constants.topOffset),
            passwordTexfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            passwordTexfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.customOffset),
            passwordTexfield.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            
            confirmLabel.topAnchor.constraint(equalTo: passwordTexfield.bottomAnchor, constant: Constants.topOffset * 4),
            confirmLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            confirmTexfield.topAnchor.constraint(equalTo: confirmLabel.bottomAnchor, constant: Constants.topOffset),
            confirmTexfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            confirmTexfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.customOffset),
            confirmTexfield.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            
            button.topAnchor.constraint(equalTo: confirmTexfield.bottomAnchor, constant: Constants.topOffset * 8),
        ])
    }
    
    private func layoutViews() {
        switch passwordPageType {
            case .requestPassword:
                setCommonLayouts()
                setRequestLayouts()
            
            case .changePassword:
                setCommonLayouts()
                setChangePasswordLayouts()
            default: break
        }
    }
    
}


