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
    
    static let verticvalTabBar: UIColor = {
        return UIColor (red: 8/255, green: 8/255, blue: 51/255, alpha: 1.0)
    }()
}


enum Image {

    /// icons
    static let arrowBack = UIImage(named: "arrowBack")
    static let arrowForward = UIImage(named: "arrowForward")
    static let editCircle = UIImage(named: "editCircle")
    static let editSquare = UIImage(named: "editSquare")
    static let heartDeselected = UIImage(named: "heartDeselected")
    static let heartSelected = UIImage(named: "heartSelected")
    static let pointBlue = UIImage(named: "pointBlue")
    static let searchMagnifying = UIImage(named: "searchMagnifying")
    static let searchContinue = UIImage(named: "searchContinue")

    /// images
    static let equalizer = UIImage(named: "equalizer")
    static let heartBlue = UIImage(named: "heartBlue")
    static let onboardingBackground = UIImage(named: "onboardingBackground")
    static let playerBack = UIImage(named: "playerBack")
    static let playerMain = UIImage(named: "playerMain")
    static let playerNext = UIImage(named: "playerNext")
    static let playPink = UIImage(named: "playPink")
    static let playWhite = UIImage(named: "playWhite")
    static let signInBackground = UIImage(named: "signInBackground")
    static let trianglePink = UIImage(named: "trianglePink")
    static let googleSignIn = UIImage(named: "google-signin")

    /// waves images
    static let waveBlue = UIImage(named: "waveBlue")
    static let waveGreen = UIImage(named: "waveGreen")
    static let waveLightRed = UIImage(named: "waveLightRed")
    static let wavePurple = UIImage(named: "wavePurple")
    static let waveRed = UIImage(named: "waveRed")
    static let waveYellow = UIImage(named: "waveYellow")
}
