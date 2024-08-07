//
//  AuthAlertManager.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 03.08.2024.
//

import UIKit

enum LoginAlert {
    case invalidEmailOrPassword
}

enum RegisterAlert {
    case invalidUsername
    case invalidEmail
    case invalidPassword
    case passwordsMismatch
}

enum ForgotPasswordAlert {
    case invalidEmail
    case invalidPassword
    case passwordsMismatch
}

final class AuthAlertManager: AlertManager {
    
    func showLoginAlert(
        on viewController: UIViewController,
        for status: LoginAlert
    ) {
        switch status {
        case .invalidEmailOrPassword:
            showInvalidEmailOrPasswordAlert(on: viewController)
        }
    }
    
    func showRegisterAlert(
        on viewController: UIViewController,
        for status: RegisterAlert
    ) {
        switch status {
        case .invalidUsername:
            showInvalidUsernameAlert(on: viewController)
        case .invalidEmail:
            showInvalidEmailAlert(on: viewController)
        case .invalidPassword:
            showInvalidPasswordAlert(on: viewController)
        case .passwordsMismatch:
            showPasswordsMismatchAlert(on: viewController)
        }
    }
    
    func showForgotPasswordAlert(
        on viewController: UIViewController,
        for status: ForgotPasswordAlert
    ) {
        switch status {
        case .invalidEmail:
            showInvalidEmailAlert(on: viewController)
        case .invalidPassword:
            showInvalidPasswordAlert(on: viewController)
        case .passwordsMismatch:
            showPasswordsMismatchAlert(on: viewController)
        }
    }
}


// Login alerts
extension AuthAlertManager {
    
    private func showInvalidEmailOrPasswordAlert(on viewController: UIViewController) {
        presentBasicAlert(
            on: viewController,
            title: NSLocalizedString("AuthScreenUserNameOrPasswordErrorTitle", comment: ""),
            message: NSLocalizedString("AuthScreenUserNameOrPasswordErrorMessage", comment: "")
        )
    }
}

// Register alerts
extension AuthAlertManager {
    
    private func showInvalidUsernameAlert(on viewController: UIViewController) {
        presentBasicAlert(
            on: viewController,
            title: NSLocalizedString("AuthScreenUserNameErrorTitle", comment: ""),
            message: NSLocalizedString("AuthScreenUserNameErrorMessage", comment: "")
        )
    }
    
    private func showInvalidEmailAlert(on viewController: UIViewController) {
        presentBasicAlert(
            on: viewController,
            title: NSLocalizedString("AuthScreenUserEmailErrorTitle", comment: ""),
            message: NSLocalizedString("AuthScreenUserEmailErrorMessage", comment: "")
        )
    }
    
    private func showInvalidPasswordAlert(on viewController: UIViewController) {
        presentBasicAlert(
            on: viewController,
            title: NSLocalizedString("AuthScreenUserPasswordErrorTitle", comment: ""),
            message: NSLocalizedString("AuthScreenUserPasswordErrorMessage", comment: "")
        )
    }
    
    private func showPasswordsMismatchAlert(on viewController: UIViewController) {
        presentBasicAlert(
            on: viewController,
            title: NSLocalizedString("AuthScreenUserPasswordRepeatErrorTitle", comment: ""),
            message: NSLocalizedString("AuthScreenUserPasswordRepeatErrorMessage", comment: "")
        )
    }
    
    func showDefaultAlert(on viewController: UIViewController, title: String, message: String) {
        presentBasicAlert(
            on: viewController,
            title: title,
            message: message)
    }
}
