//
//  OnboardingController.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 29.07.2024.
//

import UIKit

final class WelcomeController: UIViewController {
    
    private let onboardingView = WelcomeView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
