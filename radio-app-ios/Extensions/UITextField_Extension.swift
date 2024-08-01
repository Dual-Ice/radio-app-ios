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
        //code
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }
    static func makeCustomPinkTextfield(placeholderText: String?) -> UITextField {
        let element = UITextField()
        
        let paddingView = UIView(frame: CGRectMake(0, 0, 20, 20))
        element.leftView = paddingView
        element.leftViewMode = .always

        let color = UIColor.white
        let placeholderLocalized = NSLocalizedString(placeholderText ?? "LabelValue", comment: "Localizable")
        element.attributedPlaceholder = NSAttributedString(string: placeholderLocalized, attributes: [NSAttributedString.Key.foregroundColor : color])
            
        element.textAlignment = .left
        element.layer.cornerRadius = 5
        element.font = .systemFont(ofSize: 16)
        element.textColor = .blue
        element.tintColor = .red
        element.layer.borderColor = Color.customPink.cgColor
        element.layer.borderWidth = 3.0
            
        // add shadow
        element.layer.shadowColor = Color.customPink.cgColor
        element.layer.shadowOffset = CGSize(width: 3.0, height: 4.0)
        element.layer.shadowOpacity = 0.5
        element.layer.shadowRadius = CGFloat(3.0)
        element.layer.masksToBounds = false
            
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }
        
    static func makePasswordPinkTextfield(placeholderText: String?) -> UITextField {
        let element = UITextField()
        
        let paddingView = UIView(frame: CGRectMake(0, 0, 20, 20))
        element.leftView = paddingView
        element.leftViewMode = .always

        let color = UIColor.white
        let placeholderLocalized = NSLocalizedString(placeholderText ?? "LabelValue", comment: "Localizable")
        element.attributedPlaceholder = NSAttributedString(string: placeholderLocalized, attributes: [NSAttributedString.Key.foregroundColor : color])
            
        element.textAlignment = .left
        element.layer.cornerRadius = 5
        element.font = .systemFont(ofSize: 16)
        element.textColor = .blue
        element.tintColor = .red
        element.layer.borderColor = Color.customPink.cgColor
        element.layer.borderWidth = 3.0
        element.isSecureTextEntry = true
            
        // add "eye" icon
        let leftView = UIView(frame: CGRectMake(0, 0, 40, 20))
        let iconView = UIImageView(frame: CGRectMake(0, 0, 20, 20))
        leftView.addSubview(iconView)
        iconView.image = UIImage(systemName: "eye")
        iconView.contentMode = .center
        iconView.tintColor = .white
        element.rightView = leftView
        element.rightViewMode = .always
            
        // add shadow
        element.layer.shadowColor = Color.customPink.cgColor
        element.layer.shadowOffset = CGSize(width: 3.0, height: 4.0)
        element.layer.shadowOpacity = 0.5
        element.layer.shadowRadius = CGFloat(3.0)
        element.layer.masksToBounds = false
            

            
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }
}
