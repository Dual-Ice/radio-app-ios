//
//  VerticalTabBarPresenter.swift
//  radio-app-ios
//
//  Created by nik on 30.07.24.
//

import UIKit

protocol VerticalTabBarPresenterProtocol: AnyObject {
    func loadViewController(_ navigationController: UINavigationController)
    func didChooseView(_ view: String)
}

final class VerticalTabBarPresenter: VerticalTabBarPresenterProtocol {
    private unowned let tabBarController: VerticalTabBarControllerProtocol
    
    //MARK: - Modules. Enter here the name and class of the controllers to display
    private var viewControllers: [String: UIViewController] = [:]
    
    init(tabBarController: VerticalTabBarControllerProtocol) {
        self.tabBarController = tabBarController
    }
    
    func loadViewController(_ navigationController: UINavigationController) {
#warning("заполнить нужными контроллерами")
        viewControllers["Popular"] = PopularBuilder.buildPopularController(navigationController)
        viewControllers["Favorites"] = FavoritesBuilder.buildFavoritesController(navigationController)
        viewControllers["AllStations"] = AllBuilder.buildAllController(navigationController)
        
        viewControllers.keys.sorted(by: >).forEach { viewName  in
            let title = NSLocalizedString(viewName, comment: "Localizable")
            tabBarController.addTabBarButtons(title, identifier: viewName)
        }
    }
    
    func didChooseView(_ view: String) {
        tabBarController.showView(viewControllers[view] ?? UIViewController())
    }
}
