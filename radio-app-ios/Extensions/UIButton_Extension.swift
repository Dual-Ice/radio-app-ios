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
                return Color.customPink
            case .blue:
                return Color.customLightBlue
            }
        }
    }

    static func makeCustomButtonWithLabel(
        color: ButtonColor,
        key: String?) -> UIButton
    {
        let button = UIButton()
        button.backgroundColor = color.color
        button.setTitle(NSLocalizedString(key ?? "LabelValue", comment: "Localizable"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    static func makeCustomButtonWithArrow() -> UIButton {
        let button = UIButton()
        button.backgroundColor = Color.customLightBlue
        button.setImage(Image.arrowForward, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func makeCustomButtonWithImage(image: UIImage?) -> UIButton {
        let button = UIButton()
        button.setImage(image ?? Image.heartBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
