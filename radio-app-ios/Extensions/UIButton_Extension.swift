//
//  UIButton_Extension.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 29.07.2024.
//

import UIKit

extension UIButton {

    enum ButtonColor {
        case pink
        case blue

        var color: UIColor {
            switch self {
            case .pink:
                return .customPink
            case .blue:
                return .customLightBlue
            }
        }
    }

    static func makeCustomButtonWithLabel(
        color: ButtonColor,
        title: String) -> UIButton
    {
        let button = UIButton()
        button.backgroundColor = color.color
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.DisplayFont.displayRegular(size: 20)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
