//
//  AuthController.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 30.07.2024.
//

import UIKit

final class AuthController: UIViewController {
    
    private let authView = AuthView()
    private let presenter: AuthPresenter
    
    //MARK: - init(_:)
    init(presenter: AuthPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

