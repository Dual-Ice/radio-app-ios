//
//  Images.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 29.07.2024.
//

import UIKit

enum Color {

    static let backgroundBlue: UIColor = {
        return UIColor (red: 1/255, green: 1/255, blue: 42/255, alpha: 1.0)
    }()

    static let customDeepBlue: UIColor = {
        return UIColor (red: 0/255, green: 86/255, blue: 121/255, alpha: 1.0)
    }()

    static let customLightBlue: UIColor = {
        return UIColor (red: 5/255, green: 216/255, blue: 232/255, alpha: 1.0)
    }()

    static let customLightMint: UIColor = {
        return UIColor (red: 209/255, green: 249/255, blue: 255/255, alpha: 1.0)
    }()

    static let customPink: UIColor = {
        return UIColor (red: 255/255, green: 41/255, blue: 109/255, alpha: 1.0)
    }()
}


enum Image {

    static let arrowForward = UIImage(named: "arrowForward")

}

enum Constants {
    // constants for constraints
}
