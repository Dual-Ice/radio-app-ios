//
//  UIImage_Extension.swift
//  radio-app-ios
//
//  Created by nik on 08.08.24.
//

import UIKit

extension UIImage {
    func resized(to height: Int, _ width: Int ) -> UIImage {
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? self
    }
}
