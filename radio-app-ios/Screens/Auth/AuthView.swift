//
//  AuthView.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 30.07.2024.
//

import UIKit

enum AuthorizationType: String {
    case logIn = "Sign In"
    case register = "Sign Up"
}

protocol AuthViewDelegate: AnyObject {
    func tappedButton()
}

final class AuthView: UIView {
    weak var delegate: AuthViewDelegate?
    
    // MARK: - Public Properties
        
    public var authorizationType: AuthorizationType? = .logIn // delete the value after setting the navigation
    
    // MARK: - UI
    
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
    
    
    private let nameLabel = UILabel.makeCustomLabel(
        key: "NameLabel",
        fontSize: Constants.regularLabelSize,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .left)
        
    private let nameTexfield = UITextField.makeCustomPinkTextfield(placeholderText: "YourNameValue")
    
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
    
    private let signButton = UIButton.makeCustomPlainButton(title: "OrSignUpValue", fontSize: Constants.signLabelSize)
    
    // MARK: - Life Cycle
    
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
    
    // MARK: - Set Views
    
    private func setViews() {
        
        switch authorizationType {
            case .logIn:
                headingLabel.text = NSLocalizedString("SignInValue", comment: "Localizable")
                signButton.setTitle(NSLocalizedString("SignInValue", comment: "Localizable"), for: .normal)
                nameLabel.isHidden = true
                nameTexfield.isHidden = true
            case .register:
                headingLabel.text = NSLocalizedString("SignUpValue", comment: "Localizable")
                forgotButton.isHidden = true
                separatorStackView.isHidden = true
                googleImage.isHidden = true
                signButton.setTitle(NSLocalizedString("OrSignInValue", comment: "Localizable"), for: .normal)
            default: break
        }
        
        self.backgroundColor = Color.backgroundBlue
        
        self.addSubview(bgImage)
        
        [
            playImage,
            headingLabel,
            subHeadingLabel,
            nameLabel,
            nameTexfield,
            emailLabel,
            emailTexfield,
            passwordLabel,
            passwordTexfield,
            forgotButton,
            separatorStackView,
            googleImage,
            button,
            signButton
        ].forEach { bgImage.addSubview($0) }
        
        [lineViewLeft, connectLabel, lineViewRight].forEach { separatorStackView.addArrangedSubview($0) }
        
        setUpViews()
    }
    
    private func setUpViews(){
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        signButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        forgotButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(){
        delegate?.tappedButton()
    }
    
    
    // MARK: - Setup Constraints
    
    private func setCommonLayouts() {
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: self.topAnchor),
            bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bgImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bgImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            playImage.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topOffset * 10),
            playImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            headingLabel.topAnchor.constraint(equalTo: playImage.bottomAnchor, constant: Constants.topOffset * 3),
            headingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            subHeadingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: Constants.topOffset * 0.8),
            subHeadingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            emailTexfield.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Constants.topOffset),
            emailTexfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            emailTexfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.customOffset),
            emailTexfield.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTexfield.bottomAnchor, constant: Constants.topOffset * 2),
            passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            passwordTexfield.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: Constants.topOffset),
            passwordTexfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            passwordTexfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.customOffset),
            passwordTexfield.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            button.widthAnchor.constraint(equalToConstant: Constants.signButtonWidth),
            button.heightAnchor.constraint(equalToConstant: Constants.signButtonHeight),
            
            signButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset)
            
        ])
    }
    
    private func setSignInLayouts(){
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: subHeadingLabel.bottomAnchor, constant: Constants.topOffset * 4),
            
            forgotButton.topAnchor.constraint(equalTo: passwordTexfield.bottomAnchor, constant: Constants.topOffset),
            forgotButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.customOffset),
            
            separatorStackView.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: Constants.topOffset * 3),
            separatorStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            lineViewLeft.widthAnchor.constraint(equalToConstant: Constants.separatorWidth),
            lineViewLeft.heightAnchor.constraint(equalToConstant: 1),
            
            lineViewRight.widthAnchor.constraint(equalToConstant: Constants.separatorWidth),
            lineViewRight.heightAnchor.constraint(equalToConstant: 1),
            
            googleImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            googleImage.topAnchor.constraint(equalTo: separatorStackView.bottomAnchor, constant: Constants.topOffset),

            button.topAnchor.constraint(equalTo: googleImage.bottomAnchor, constant: Constants.topOffset * 4),
            
            signButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: Constants.topOffset * 2),
        ])
    }
    
    private func setSignUpLayouts(){
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: subHeadingLabel.bottomAnchor, constant: Constants.topOffset * 4),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            nameTexfield.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.topOffset),
            nameTexfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            nameTexfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.customOffset),
            nameTexfield.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            
            emailLabel.topAnchor.constraint(equalTo: nameTexfield.bottomAnchor, constant: Constants.topOffset * 2),
        
            button.topAnchor.constraint(equalTo: passwordTexfield.bottomAnchor, constant: Constants.topOffset * 4),
            
            signButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: Constants.topOffset * 2)
            
        ])
    }
    
    private func layoutViews() {
        switch authorizationType {
            case .logIn:
                setCommonLayouts()
                setSignInLayouts()
            
            case .register:
                setCommonLayouts()
                setSignUpLayouts()
            default: break
        }
    }
}

