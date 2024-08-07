//
//  UITextField_Extension.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 30.07.2024.
//

import UIKit

extension UITextField {

    static func makeTextField() -> UITextField {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }
    
    static func makeCustomPinkTextfield(placeholderText: String?, isSecure: Bool, keyboardType: UIKeyboardType) -> UITextField {
        let element = UITextField()
        element.keyboardType = keyboardType
        
        let paddingView = UIView(frame: CGRectMake(0, 0, 20, 20))
        element.leftView = paddingView
        element.leftViewMode = .always

        let color = UIColor.white
        let placeholderLocalized = NSLocalizedString(placeholderText ?? "LabelValue", comment: "Localizable")
        element.attributedPlaceholder = NSAttributedString(string: placeholderLocalized, attributes: [NSAttributedString.Key.foregroundColor : color.withAlphaComponent(0.5)])
        
        element.textAlignment = .left
        element.layer.cornerRadius = 5
        element.font = .systemFont(ofSize: 16)
        element.textColor = .white
        element.tintColor = Color.customPink
        element.layer.borderColor = Color.customPink.cgColor
        element.layer.borderWidth = 3.0
        
        // add shadow
        element.layer.shadowColor = Color.customPink.cgColor
        element.layer.shadowOffset = CGSize(width: 3.0, height: 4.0)
        element.layer.shadowOpacity = 0.5
        element.layer.shadowRadius = CGFloat(3.0)
        element.layer.masksToBounds = false
        
        element.translatesAutoresizingMaskIntoConstraints = false
        
        if (isSecure) {
            element.isSecureTextEntry = true
            element.setSecureInputButton()
        }
        
        return element
    }
        
    func setSecureInputButton() {
        let button = UIButton(type: .custom)
        let showPass = UIImage(systemName: "eye")
        let hidePass = UIImage(systemName: "eye.slash")
        let action = UIAction { [weak self] action in
            self?.isSecureTextEntry.toggle()
            let image = self?.isSecureTextEntry ?? true ? showPass : hidePass
            button.setImage(image, for: .normal)
        }
        button.frame = CGRect(x: 16, y: 10, width: 20, height: 20)
        button.setImage(showPass, for: .normal)
        button.addAction(action, for: .touchUpInside)
        button.sizeToFit()
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        containerView.addSubview(button)
        rightView = containerView
        rightViewMode = .always
    }


}
