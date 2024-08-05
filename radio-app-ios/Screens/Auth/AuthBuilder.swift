//
//  AuthBuilder.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 03.08.2024.
//

import UIKit


protocol AuthBuilderProtocol: AnyObject {
    
    func buildAuth(router: AuthRouterProtocol) -> UIViewController

    func buildResetPassword(router: AuthRouterProtocol) -> UIViewController
    
    func buildAuthRouter() -> AuthRouter
}

final class AuthBuilder: AuthBuilderProtocol {
    
    private let navigationVC: UINavigationController
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildAuthRouter() -> AuthRouter {
        AuthRouter(navigationVC: navigationVC, builder: self)
    }
    
    func buildAuth(router: AuthRouterProtocol) -> UIViewController {
        let presenter = AuthPresenter(router: router)
        let vc = AuthController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func buildResetPassword(router: AuthRouterProtocol) -> UIViewController {
        let presenter = ResetPasswordPresenter(router: router)
        let vc = PasswordController(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
