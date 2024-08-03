//
//  AuthPresenter.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 03.08.2024.
//

import Foundation

final class AuthPresenter {
    private let router: AuthRouterProtocol
    
    weak var view: AuthController?
    
    //MARK: - init(_:)
    required init(router: AuthRouterProtocol) {
        self.router = router
    }
}
