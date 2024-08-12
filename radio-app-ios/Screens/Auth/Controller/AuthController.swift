//
//  AuthController.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 30.07.2024.
//

import UIKit

final class AuthController: UIViewController {
    
    private let authView = AuthView()
    private let presenter: AuthPresenter
    private let authAlertManager = AuthAlertManager()
    
    //MARK: - init(_:)
    init(presenter: AuthPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authView.setDelegates(self)
        setupKeyboardObservers()
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.authView.hideKeyboard()
    }
}

extension AuthController {
    func showLoginAlert(for status: LoginAlert) {
        authAlertManager.showLoginAlert(on: self, for: status)
    }
    
    func showRegisterAlert(for status: RegisterAlert) {
        authAlertManager.showRegisterAlert(on: self, for: status)
    }
    
    func showDefaultAlert(message: String) {
        authAlertManager.showDefaultAlert(on: self, title: NSLocalizedString("AuthSceenRegistrationErrorTitle", comment: ""), message: message)
    }
    
    func goToMain() {
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    }
}

extension AuthController: AuthViewDelegate {
    
    func googleButtonTapped() {
        presenter.loginViaGoogle(presentingViewController: self)
    }
    
    func forgotButtonTapped() {
        presenter.forgotPassword()
    }
    
    func handleLogin(with request: LoginUserRequest) {
        presenter.loginUser(with: request)
    }
    
    func handleRegister(with request: RegisterUserRequest) {
        presenter.registerUser(with: request)
    }
    
}

