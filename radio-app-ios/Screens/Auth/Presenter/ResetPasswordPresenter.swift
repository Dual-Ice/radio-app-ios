//
//  ResetPasswordPresenter.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 03.08.2024.
//

import Foundation

final class ResetPasswordPresenter {
    private let router: AuthRouterProtocol
    
    weak var view: PasswordController?
    
    //MARK: - init(_:)
    required init(router: AuthRouterProtocol) {
        self.router = router
    }
}
