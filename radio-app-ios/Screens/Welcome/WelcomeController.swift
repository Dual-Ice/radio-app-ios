//
//  OnboardingController.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 29.07.2024.
//

import UIKit

final class WelcomeController: UIViewController {
    
    private let welcomeView = WelcomeView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = welcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeView.setDelegates(self)
    }
}

extension WelcomeController: WelcomeViewDelegate {
    func tappedButton() {
        print("Button is tapped")
    }
}
