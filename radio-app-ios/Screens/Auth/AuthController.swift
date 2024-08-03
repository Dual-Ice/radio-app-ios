//
//  AuthController.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 30.07.2024.
//

import UIKit

final class AuthController: UIViewController {
    
    private let authView = AuthView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authView.setDelegates(self)
    }


}

extension AuthController: AuthViewDelegate {
    func tappedButton(_ sender: UIButton) {
        print("Button is tapped - \(sender.currentTitle ?? "Empty button")")
    }
}

