//
//  AuthView.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 30.07.2024.
//

import UIKit

enum AuthorizationState: String {
    case logIn
    case register
}

protocol AuthViewDelegate: AnyObject {
    func handleLoginButtonTap(
        with request: LoginUserRequest
    )
    func handleRegisterButtonTap(
        with request: RegisterUserRequest
    )
    func googleButtonTapped()
    func forgotButtonTapped()
}

final class AuthView: UIView {
    weak var delegate: AuthViewDelegate?
    
    // MARK: - Public Properties
    
    public var authorizationState: AuthorizationState = .logIn {
        didSet {
            layoutViews()
            configureUI()
        }
    }
    
    // MARK: - UI
    private var customConstraints = [NSLayoutConstraint]()
    
    private let playImage = UIImageView.makeSimpleImage(imageName: "playPink")
    private let bgImage = UIImageView.makeSimpleImage(imageName: "signInBackground")
    private var triangleImage = UIImageView.makeSimpleImage(imageName: "trianglePink")
    
    
    private let headingLabel = UILabel.makeCustomLabelBold(
        key: "SignIn",
        fontSize: Constants.headingSize,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .center)
    
    private let subHeadingLabel = UILabel.makeCustomLabel(
        key: "Subheading",
        fontSize: Constants.subHeadingSize,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .left)
    
    
    private let nameField = FormField(labelText: "NameLabel", placeholder: "YourName", isSecure: false)
    private let emailField = FormField(labelText: "EmailLabel", placeholder: "YourEmail", isSecure: false)
    private let passwordField = FormField(labelText: "PasswordLabel", placeholder: "YourPassword", isSecure: true)
    
    
    private lazy var inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.topOffset * 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let forgotButton = UIButton.makeCustomPlainButton(title: "ForgotButton", fontSize: Constants.forgotLabelSize)
    
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
        key: "Connect",
        fontSize: Constants.connectLabelSize,
        textColor: .white.withAlphaComponent(0.5),
        numberOfLines: nil,
        textAligment: .center)
    
    private let googleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(Image.googleSignIn, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let submitButton = UIButton.makeCustomButtonWithArrow()
    
    private let signButton = UIButton.makeCustomPlainButton(title: "OrSignUp", fontSize: Constants.signLabelSize)
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegates(_ value: AuthController) {
        delegate = value
    }
    
    // MARK: - Set Views
    
    private func setViews() {
        self.backgroundColor = Color.backgroundBlue
        
        self.addSubview(bgImage)
        
        [
            triangleImage,
            playImage,
            headingLabel,
            subHeadingLabel,
            inputStackView,
            forgotButton,
            separatorStackView,
            googleButton,
            submitButton,
            signButton
        ].forEach { bgImage.addSubview($0) }
        
        [lineViewLeft, connectLabel, lineViewRight].forEach { separatorStackView.addArrangedSubview($0) }
        
        [nameField, emailField, passwordField].forEach { inputStackView.addArrangedSubview($0) }
        
        setUpViews()
    }
    
    private func setUpViews(){
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        signButton.addTarget(self, action: #selector(changeAuthAction), for: .touchUpInside)
        forgotButton.addTarget(self, action: #selector(forgotPasswordAction), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleAction), for: .touchUpInside)
    }
    
    @objc private func submit(_ sender: UIButton){
        switch authorizationState {
        case .logIn:
            makeLoginRequest()
        case .register:
            makeRegisterRequest()
        }
    }
    
    @objc private func changeAuthAction(_ sender: UIButton){
        authorizationState = authorizationState == .logIn ? .register : .logIn
    }
    
    @objc private func forgotPasswordAction(_ sender: UIButton){
        delegate?.forgotButtonTapped()
    }
    
    @objc private func googleAction(_ sender: UIButton){
        delegate?.googleButtonTapped()
    }
    
    private func makeRegisterRequest() {
        let username = nameField.getFieldValue()
        let email = emailField.getFieldValue()
        let password = passwordField.getFieldValue()
 
        let request = RegisterUserRequest(
            username: username,
            email: email,
            password: password
        )
        
        delegate?.handleRegisterButtonTap(with: request)
    }
    
    private func makeLoginRequest() {
        let email = emailField.getFieldValue()
        let password = passwordField.getFieldValue()
        
        let request = LoginUserRequest(
            email: email,
            password: password
        )
        
        delegate?.handleLoginButtonTap(with: request)
    }
    
    
    // MARK: - Setup Constraints
    
    private func setCommonLayouts() {
        let constraints = [
            bgImage.topAnchor.constraint(equalTo: self.topAnchor),
            bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bgImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bgImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            triangleImage.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topOffset * 8),
            triangleImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            playImage.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topOffset * 10),
            playImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            headingLabel.topAnchor.constraint(equalTo: playImage.bottomAnchor, constant: Constants.topOffset * 3),
            headingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            subHeadingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: Constants.topOffset * 0.8),
            subHeadingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            inputStackView.topAnchor.constraint(equalTo: subHeadingLabel.bottomAnchor, constant: Constants.customOffset),
            inputStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            inputStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.customOffset),
            
            submitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            submitButton.widthAnchor.constraint(equalToConstant: Constants.signButtonWidth),
            submitButton.heightAnchor.constraint(equalToConstant: Constants.signButtonHeight),
            
            signButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset)
            
        ]
        
        activate(constraints: constraints)
    }
    
    private func setSignInLayouts(){
        let constraints = [
            forgotButton.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: Constants.topOffset),
            forgotButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.customOffset),
            
            separatorStackView.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: Constants.topOffset * 3),
            separatorStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            lineViewLeft.widthAnchor.constraint(equalToConstant: Constants.separatorWidth),
            lineViewLeft.heightAnchor.constraint(equalToConstant: 1),
            
            lineViewRight.widthAnchor.constraint(equalToConstant: Constants.separatorWidth),
            lineViewRight.heightAnchor.constraint(equalToConstant: 1),
            
            googleButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            googleButton.topAnchor.constraint(equalTo: separatorStackView.bottomAnchor, constant: Constants.topOffset),
            
            submitButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: Constants.topOffset * 4),
            
            signButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: Constants.topOffset * 2),
        ]
        
        activate(constraints: constraints)
    }
    
    private func setSignUpLayouts(){
        let constraints = [
            submitButton.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: Constants.topOffset * 4),
            
            signButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: Constants.topOffset * 2)
        ]
        
        activate(constraints: constraints)
    }
    
    private func activate(constraints: [NSLayoutConstraint]) {
        customConstraints.append(contentsOf: constraints)
        customConstraints.forEach { $0.isActive = true }
    }
    
    private func clearConstraints() {
        customConstraints.forEach { $0.isActive = false }
        customConstraints.removeAll()
    }
    
    private func layoutViews() {
        clearConstraints()
        setCommonLayouts()
        
        switch authorizationState {
        case .logIn:
            setSignInLayouts()
        case .register:
            setSignUpLayouts()
        }
        
        self.layoutIfNeeded()
    }
    
    private func configureUI() {
        switch authorizationState {
        case .logIn:
            headingLabel.text = NSLocalizedString("SignIn", comment: "Localizable")
            signButton.setTitle(NSLocalizedString("OrSignUp", comment: "Localizable"), for: .normal)
            nameField.isHidden = true
            forgotButton.isHidden = false
            separatorStackView.isHidden = false
            googleButton.isHidden = false
        case .register:
            headingLabel.text = NSLocalizedString("SignUp", comment: "Localizable")
            forgotButton.isHidden = true
            separatorStackView.isHidden = true
            googleButton.isHidden = true
            signButton.setTitle(NSLocalizedString("OrSignIn", comment: "Localizable"), for: .normal)
            nameField.isHidden = false
        }
    }
}

