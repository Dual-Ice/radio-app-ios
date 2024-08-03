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
    
    func handleLoginButtonTap(with request: LoginUserRequest) {
        presenter.loginUser(with: request)
    }
    
    func handleRegisterButtonTap(with request: RegisterUserRequest) {
        presenter.registerUser(with: request)
    }
    
}

