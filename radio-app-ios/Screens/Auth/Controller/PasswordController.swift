//
//  PasswordController.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 31.07.2024.
//

import UIKit

final class PasswordController: UIViewController {
    
    private let passwordView = PasswordView()
    private let presenter: ResetPasswordPresenter
    private let passwordForgotAlertManager = AuthAlertManager()
    
    //MARK: - init(_:)
    init(presenter: ResetPasswordPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = passwordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordView.setDelegates(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.passwordView.hideKeyboard()
    }
}

extension PasswordController {
    func showForgotPasswordAlert(for status: ForgotPasswordAlert) {
        passwordForgotAlertManager.showForgotPasswordAlert(on: self, for: status)
    }
    
    func showDefaultAlert(message: String) {
        passwordForgotAlertManager.showDefaultAlert(on: self, title: NSLocalizedString("AuthSceenResetPasswordErrorTitle", comment: ""), message: message)
    }
    
    func nextStepToResetPassword() {
        passwordForgotAlertManager.presentAlertWithAction(
            from: self,
            title: NSLocalizedString("AuthSceenPasswordResetSuccessTitle", comment: ""),
            message: NSLocalizedString("AuthSceenPasswordResetSuccessMessage", comment: "")
        ) {
//            self.passwordView.changeStateToPasswordUpdate()
        }
    }
    
}

extension PasswordController: PasswordViewDelegate {
    func handleEmailSend(with request: ResetPasswordRequest) {
        presenter.resetUserPassword(with: request)
    }
    
    func handlePasswordSet(with request: UpdatePasswordRequest) {
        presenter.setUserPassword(with: request)
    }
    
    func backButtonPressed() {
        presenter.goBack()
    }
}

