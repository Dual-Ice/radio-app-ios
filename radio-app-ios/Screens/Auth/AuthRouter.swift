//
//  AuthRouter.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 03.08.2024.
//

import UIKit

protocol AuthRouterProtocol: AnyObject {
    init(navigationVC: UINavigationController, builder: AuthBuilder)
    
    func goToResetPasswordVC()
    
    func dismiss()
}

final class AuthRouter: AuthRouterProtocol {
    private let builder: AuthBuilder
    private let navigationVC: UINavigationController
    
    required init(
        navigationVC: UINavigationController,
        builder: AuthBuilder
    ) {
        self.navigationVC = navigationVC
        self.builder = builder
    }
    
    func dismiss() {
        navigationVC.popViewController(animated: true)
    }
    
    func goToResetPasswordVC() {
        let vc = builder.buildResetPassword(router: self)
        navigationVC.pushViewController(vc, animated: true)
    }
}
