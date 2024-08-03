//
//  ViewController.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 29.07.2024.
//

import UIKit

final class PopularController: UIViewController {
    
    private let popularView = PopularView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = popularView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popularView.setDelegates(self)
    }


}

extension PopularController: PopularViewDelegate {
    func tappedButton() {
        var request = RegisterUserRequest(username: "test", email: "test@m.ru", password: "123456")
        AuthManager.shared.registerUser(with: request) { registeredUser, error in
            if let error = error {
                print("error")
                return
            }
            
            guard let user = registeredUser else {
                return
            }
            print(user)
            UserManager.shared.setUser(userObject: user)
        }
    }
    
}

