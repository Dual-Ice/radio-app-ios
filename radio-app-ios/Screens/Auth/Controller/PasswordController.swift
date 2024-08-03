//
//  PasswordController.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 31.07.2024.
//

import UIKit

final class PasswordController: UIViewController {
    
    private let passwordView = PasswordView()
    private let presenter: ResetPasswordPresenter
    
    //MARK: - init(_:)
    init(presenter: ResetPasswordPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

