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
        // Сохраняем состояние, что Welcome был показан
        UserDefaults.standard.set(true, forKey: "isWelcomeCompleted")
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        let nextController: UIViewController
        
        if isLoggedIn {
            nextController = PopularController()
        } else {
            nextController = PopularController() //Исправить на LoginController
        }
        
        if let windowScene = view.window?.windowScene {
            UIView.transition(with: windowScene.windows.first!,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                                  windowScene.windows.first?.rootViewController = nextController
                              },
                              completion: nil)
        }
    }
}
