//
//  ResetPasswordPresenter.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 03.08.2024.
//

import Foundation

final class ResetPasswordPresenter {
    private let router: AuthRouterProtocol
    private let authManager = AuthManager()
    
    weak var view: PasswordController?
    
    //MARK: - init(_:)
    required init(router: AuthRouterProtocol) {
        self.router = router
    }
    
    
    func goBack() {
        router.dismiss()
    }
    
    func resetUserPassword(with request: ResetPasswordRequest) {
        if !ValidationManager.isValidEmail(request.email) {
            view?.showForgotPasswordAlert(for: .invalidEmail)
            return
        }
        
        authManager.passwordReset(with: request.email) { success, error in
            if let error = error {
                self.view?.showDefaultAlert(message: error.localizedDescription)
                return
            }
            
            self.view?.nextStepToResetPassword()
        }
        
    }
    
    func setUserPassword(with request: UpdatePasswordRequest) {
        if !ValidationManager.isValidPassword(request.password) {
            view?.showForgotPasswordAlert(for: .invalidPassword)
            return
        }
                
        if request.password != request.confirmPassword {
            view?.showForgotPasswordAlert(for: .passwordsMismatch)
            return
        }
        
        authManager.passwordChange(with: request.password) {
            success, error in
            if let error = error {
                self.view?.showDefaultAlert(message: error.localizedDescription)
                return
            }
            
            // show Alert about success password change
        }
    }
}
