//
//  DetailRouter.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 08.08.2024.
//
import UIKit

protocol DetailRouterProtocol: AnyObject {
    init(navigationVC: UINavigationController)
    
    func dismiss()
    func goToProfileSettings()
}

final class DetailRouter: DetailRouterProtocol {
    private let navigationVC: UINavigationController
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func dismiss() {
        navigationVC.popViewController(animated: true)
    }
    
    func goToProfileSettings() {
        print("go to profile")
    }
}
