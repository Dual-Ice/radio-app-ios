//
//  VerticalTabBarBuilder.swift
//  radio-app-ios
//
//  Created by nik on 30.07.24.
//

import UIKit

final class VerticalTabBarBuilder {
    static func build() -> UIViewController {
        let vc = VerticalTabBarController()
        let presenter = VerticalTabBarPresenter(tabBarController: vc)
        vc.presenter = presenter
        
        return vc
    }
}
