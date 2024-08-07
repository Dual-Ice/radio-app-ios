//
//  UIView_Extension.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 31.07.2024.
//

import UIKit

extension UIView {
    
    static func makeSeparatorLine() -> UIView {
        let element = UIView()
        element.backgroundColor = .white.withAlphaComponent(0.5)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }
}
