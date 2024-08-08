//
//  UIImageView_Extension.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 31.07.2024.
//

import UIKit

extension UIImageView {

    static func makeSimpleImage(imageName: String) -> UIImageView {
        let image = UIImageView()
        //code
        image.image = UIImage(named: imageName)
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
    
    static func makeSystemImage(imageName: String, color: UIColor) -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(systemName: imageName)
        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFit
        image.tintColor = color
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
}
