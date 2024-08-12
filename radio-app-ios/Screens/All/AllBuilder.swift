//
//  AllBuilder.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 11.08.2024.
//

import UIKit

final class AllBuilder {
    static func buildAllController(_ navigationController: UINavigationController) -> UIViewController {
        let router = AllRouter(navigationController)
        let presenter = AllPresenter(allRoute: router)
        let vc = AllController(presenter: presenter)
        presenter.allVC = vc
        
        return vc
    }
}
