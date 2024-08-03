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
}
