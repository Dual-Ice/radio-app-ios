//
//  PasswordController.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 31.07.2024.
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
    func tappedButton(_ sender: UIButton) {
        print("Button is tapped - \(sender.currentTitle ?? "Empty button")")
    }
}

