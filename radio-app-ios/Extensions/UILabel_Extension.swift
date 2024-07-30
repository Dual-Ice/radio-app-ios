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
        fontSize: CGFloat,
        textColor: UIColor,
        numberOfLines: Int?,
        textAligment: NSTextAlignment?) -> UILabel
    {
        let label = UILabel()
        label.text = NSLocalizedString(key ?? "LabelValue", comment: "Localizable")
        label.numberOfLines = numberOfLines ?? 0
        label.font = .systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.textAlignment = textAligment ?? .left
        label.adjustsFontSizeToFitWidth = false
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    static func makeCustomLabelBold(
        key: String?,
        fontSize: CGFloat,
        textColor: UIColor,
        numberOfLines: Int?,
        textAligment: NSTextAlignment?) -> UILabel
    {
        let label = UILabel()
        label.text = NSLocalizedString(key ?? "LabelValue", comment: "Localizable")
        label.numberOfLines = numberOfLines ?? 0
        label.font = .boldSystemFont(ofSize: fontSize)
        label.textColor = textColor
        label.textAlignment = textAligment ?? .left
        label.adjustsFontSizeToFitWidth = false
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
