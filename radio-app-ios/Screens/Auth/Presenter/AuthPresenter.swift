//
//  AuthPresenter.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 03.08.2024.
//

import Foundation
import GoogleSignIn
import FirebaseAuth

final class AuthPresenter {
    private let router: AuthRouterProtocol
    private let authManager = AuthManager()
    
    weak var view: AuthController?
    
    //MARK: - init(_:)
    required init(router: AuthRouterProtocol) {
        self.router = router
    }
    
    func loginUser(with request: LoginUserRequest) {
        if !ValidationManager.isValidPassword(request.password) {
            view?.showLoginAlert(for: .invalidEmailOrPassword)
            return
        }
        
        authManager.signInViaEmail(with: request) { error in
            if let error = error {
                self.view?.showDefaultAlert(message: error.localizedDescription)
                return
            }
            
            self.view?.goToMain()
        }
    }
    
    func registerUser(with request: RegisterUserRequest) {
        
        if !ValidationManager.isValidDisplayName(request.username) {
            view?.showRegisterAlert(for: .invalidUsername)
            return
        }

        if !ValidationManager.isValidEmail(request.email) {
            view?.showRegisterAlert(for: .invalidEmail)
            return
        }

        if !ValidationManager.isValidPassword(request.password) {
            view?.showRegisterAlert(for: .invalidPassword)
            return
        }
        
        authManager.registerUser(with: request) { registeredUser, error in
            if let error = error {
                self.view?.showDefaultAlert(message: error.localizedDescription)
                return
            }
            
            guard let user = registeredUser else {
                self.view?.showDefaultAlert(message: NSLocalizedString("AuthSceenRegistrationUnexpectedError", comment: ""))
                return
            }
            UserManager.shared.setUser(userObject: user)
            
            self.view?.goToMain()
        }
       
    }
    
    func loginViaGoogle(presentingViewController: UIViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { authentication, error in
            if let error = error {
                self.view?.showDefaultAlert(message: error.localizedDescription)
                return
            }
            
            guard let user = authentication?.user, let idToken = user.idToken?.tokenString else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            self.authManager.signInViaGoogleCredentials(with: credential) { error in
                if let error = error {
                    self.view?.showDefaultAlert(message: error.localizedDescription)
                    return
                }
                
                self.view?.goToMain()
            }
        }
    }
    
    func forgotPassword() {
        router.goToResetPasswordVC()
    }
}
