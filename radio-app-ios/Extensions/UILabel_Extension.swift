//
//  UILabel_Extension.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 29.07.2024.
//

import UIKit

extension UILabel {
    
    static func makeCustomLabel(
        key: String?,
        font: UIFont,
        textColor: UIColor,
        numberOfLines: Int?,
        textAligment: NSTextAlignment?) -> UILabel
    {
        let label = UILabel()
        label.text = NSLocalizedString(key ?? "LabelValue", comment: "Localizable")
        label.numberOfLines = numberOfLines ?? 0
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAligment ?? .left
        label.adjustsFontSizeToFitWidth = false
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

/// standartized label for SignIn Screen
    static func makeSignInTitleLabel(key: String?) -> UILabel {
        let label = UILabel.makeCustomLabel(
            key: key,
            font: UIFont.TextFont.Onboarding.bitTitle, 
            textColor: .white,
            numberOfLines: 2,
            textAligment: .left)
        return label
    }
}
