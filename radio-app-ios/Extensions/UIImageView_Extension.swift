//
//  UIImageView_Extension.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 31.07.2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func getImage(from url: URL) {
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "waveform"),
            options: [
                .transition(.fade(1))
            ]
        )
    }

    static func makeSimpleImage(imageName: String) -> UIImageView {
        let image = UIImageView()
        //code
        image.image = UIImage(named: imageName)
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
}
