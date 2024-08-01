//
//  UIView_Extension.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 01.08.2024.
//

import UIKit

extension UIView {
    
    static func makeSeparatorLine() -> UIView {
        let element = UIView()
        element.backgroundColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }
}

