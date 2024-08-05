//
//  AlertManager.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 03.08.2024.
//

import UIKit

class AlertManager {
    
    init() {}
    
    func presentBasicAlert(
        on viewController: UIViewController,
        title: String,
        message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("AuthScreenUDismissButtonText", comment: ""), style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
    
    func presentAlertWithAction(
        from viewController: UIViewController,
        title: String,
        message: String,
        completion: @escaping () -> Void
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString("AuthScreenOkButtonText", comment: ""), style: .default) { _ in
            completion()
        }
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}
