//
//  PasswordController.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 01.08.2024.
//

import UIKit

final class PasswordController: UIViewController {
    
    private let passwordView = PasswordView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = passwordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordView.setDelegates(self)
    }


}

extension PasswordController: PasswordViewDelegate {
    func tappedButton() {
        print("Button is tapped")
    }
    
}

