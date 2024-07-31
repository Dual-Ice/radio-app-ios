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

extension UIView {
func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
}

final class AuthView: UIView {
    weak var delegate: AuthViewDelegate?
    
    private let playImage = UIImageView.makeSimpleImage(imageName: "playPink")
    private let bgImage = UIImageView.makeSimpleImage(imageName: "bgLogin")
    private let googleImage = UIImageView.makeSimpleImage(imageName: "googlePlus")

    private let headingLabel = UILabel.makeCustomLabelBold(
        key: "Sign in",
        fontSize: 40,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .center)
    
    private let subHeadingLabel = UILabel.makeCustomLabel(
        key: "to start play",
        fontSize: 20,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .left)
    
    private let emailLabel = UILabel.makeCustomLabel(
        key: "Email",
        fontSize: 20,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .left)
        
    private let emailTexfield = UITextField.makeCustomPinkTextfield(placeholderText: "Your email")
    
    private let passwordLabel = UILabel.makeCustomLabel(
        key: "Password",
        fontSize: 20,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .left)
    
    
    private let forgotButton = UIButton.makeCustomPlainButton(title: "Forgot password?", fontSize: CGFloat(20))
    
    private let passwordTexfield = UITextField.makeCustomPinkTextfield(placeholderText: "Your password")
    
    private lazy var separatorStackView: UIStackView = {
        var element = UIStackView()
        element.axis = .horizontal
        element.spacing = 10
        element.alignment = .center
        element.distribution = .equalCentering
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var lineViewRight: UIView = {
        let element = UIView()
        element.backgroundColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var lineViewLeft: UIView = {
        let element = UIView()
        element.backgroundColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var connectLabel = UILabel.makeCustomLabel(
        key: "or connect with",
        fontSize: 20,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .center)
    
    private let button = UIButton.makeCustomButtonWithArrow()
    
    private let signUpButton = UIButton.makeCustomPlainButton(title: "or Sign Up", fontSize: CGFloat(25))
    
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
        self.backgroundColor = Color.customDeepBlue
        
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
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: self.topAnchor),
            bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bgImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bgImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            playImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            playImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            
            headingLabel.topAnchor.constraint(equalTo: playImage.bottomAnchor, constant: 50),
            headingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            
            subHeadingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: Constants.sideOffset),
            subHeadingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            
            emailLabel.topAnchor.constraint(equalTo: subHeadingLabel.bottomAnchor, constant: 50),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            
            emailTexfield.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailTexfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            emailTexfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.sideOffset),
            emailTexfield.heightAnchor.constraint(equalToConstant: 53),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTexfield.bottomAnchor, constant: 50),
            passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            
            passwordTexfield.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTexfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            passwordTexfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.sideOffset),
            passwordTexfield.heightAnchor.constraint(equalToConstant: 53),
            
            forgotButton.topAnchor.constraint(equalTo: passwordTexfield.bottomAnchor, constant: 10),
            forgotButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.sideOffset),
            
            separatorStackView.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: 30),
            separatorStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            lineViewLeft.widthAnchor.constraint(equalToConstant: 93),
            lineViewLeft.heightAnchor.constraint(equalToConstant: 1),
            
            lineViewRight.widthAnchor.constraint(equalToConstant: 93),
            lineViewRight.heightAnchor.constraint(equalToConstant: 1),
            
            googleImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            googleImage.topAnchor.constraint(equalTo: separatorStackView.bottomAnchor, constant: 30),

            button.topAnchor.constraint(equalTo: googleImage.bottomAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset),
            button.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            
            signUpButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
            signUpButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.sideOffset)
        ])
    }
    
    @objc private func buttonTapped(){
        delegate?.tappedButton()
    }
    
}

