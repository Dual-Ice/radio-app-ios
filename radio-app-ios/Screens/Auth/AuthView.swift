//
//  AuthView.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 30.07.2024.
//

import UIKit


protocol AuthViewDelegate: AnyObject {
    func tappedButton()
}

final class AuthView: UIView {
    weak var delegate: AuthViewDelegate?
    
    private let playImage = UIImageView.makeSimpleImage(imageName: "playPink")
    private let bgImage = UIImageView.makeSimpleImage(imageName: "bgLogin")
    private let googleImage = UIImageView.makeSimpleImage(imageName: "googlePlus")

    private let headingLabel = UILabel.makeCustomLabelBold(
        key: "SignInValue",
        fontSize: Constants.headingSize,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .center)
    
    private let subHeadingLabel = UILabel.makeCustomLabel(
        key: "SubheadingValue",
        fontSize: Constants.subHeadingSize,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .left)
    
    private let emailLabel = UILabel.makeCustomLabel(
        key: "EmailLabel",
        fontSize: Constants.regularLabelSize,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .left)
        
    private let emailTexfield = UITextField.makeCustomPinkTextfield(placeholderText: "YourEmailValue")
    
    private let passwordLabel = UILabel.makeCustomLabel(
        key: "PasswordLabel",
        fontSize: Constants.regularLabelSize,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .left)
    
    
    private let forgotButton = UIButton.makeCustomPlainButton(title: "ForgotButtonValue", fontSize: Constants.forgotLabelSize)
    
    private let passwordTexfield = UITextField.makeCustomPinkTextfield(placeholderText: "YourPasswordValue")
    
    private lazy var separatorStackView: UIStackView = {
        var element = UIStackView()
        element.axis = .horizontal
        element.spacing = 10
        element.alignment = .center
        element.distribution = .equalCentering
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let lineViewRight = UIView.makeSeparatorLine()
    private let lineViewLeft = UIView.makeSeparatorLine()
    
    private lazy var connectLabel = UILabel.makeCustomLabel(
        key: "ConnectValue",
        fontSize: Constants.connectLabelSize,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .center)
    
    private let button = UIButton.makeRectangularButtonWithArrow()
    
    private let signUpButton = UIButton.makeCustomPlainButton(title: "OrSignUpValue", fontSize: Constants.signLabelSize)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegates(_ value: AuthController) {
        delegate = value
    }
    
    private func setViews() {
        self.backgroundColor = .black
        
        self.addSubview(bgImage)
        
        [
            playImage,
            headingLabel,
            subHeadingLabel,
            emailLabel,
            emailTexfield,
            passwordLabel,
            passwordTexfield,
            forgotButton,
            separatorStackView,
            googleImage,
            button,
            signUpButton
        ].forEach { bgImage.addSubview($0) }
        
        [lineViewLeft, connectLabel, lineViewRight].forEach { separatorStackView.addArrangedSubview($0) }
        
        setUpViews()
    }
    
    private func setUpViews(){
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        forgotButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: self.topAnchor),
            bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bgImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bgImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            playImage.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topOffset * 10),
            playImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            
            headingLabel.topAnchor.constraint(equalTo: playImage.bottomAnchor, constant: Constants.topOffset * 3),
            headingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            
            subHeadingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: Constants.topOffset * 0.8),
            subHeadingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            
            emailLabel.topAnchor.constraint(equalTo: subHeadingLabel.bottomAnchor, constant: Constants.topOffset * 4),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            
            emailTexfield.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Constants.topOffset),
            emailTexfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            emailTexfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.sideOffset),
            emailTexfield.heightAnchor.constraint(equalToConstant: 53),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTexfield.bottomAnchor, constant: Constants.topOffset * 2),
            passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            
            passwordTexfield.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: Constants.topOffset),
            passwordTexfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            passwordTexfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.sideOffset),
            passwordTexfield.heightAnchor.constraint(equalToConstant: 53),
            
            forgotButton.topAnchor.constraint(equalTo: passwordTexfield.bottomAnchor, constant: Constants.topOffset),
            forgotButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.sideOffset),
            
            separatorStackView.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: Constants.topOffset * 3),
            separatorStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            lineViewLeft.widthAnchor.constraint(equalToConstant: 93),
            lineViewLeft.heightAnchor.constraint(equalToConstant: 1),
            
            lineViewRight.widthAnchor.constraint(equalToConstant: 93),
            lineViewRight.heightAnchor.constraint(equalToConstant: 1),
            
            googleImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            googleImage.topAnchor.constraint(equalTo: separatorStackView.bottomAnchor, constant: Constants.topOffset),

            button.topAnchor.constraint(equalTo: googleImage.bottomAnchor, constant: Constants.topOffset * 4),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            button.widthAnchor.constraint(equalToConstant: Constants.signButtonWidth),
            button.heightAnchor.constraint(equalToConstant: Constants.signButtonHeight),
            
            signUpButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: Constants.topOffset * 2),
            signUpButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset)
        ])
    }
    
    @objc private func buttonTapped(){
        delegate?.tappedButton()
    }
    
}

