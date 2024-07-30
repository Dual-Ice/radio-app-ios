//
//  VerticalTabBarPresenter.swift
//  radio-app-ios
//
//  Created by nik on 30.07.24.
//

import UIKit

//MARK: - View Types
enum ViewType: String, CaseIterable {
    case popular = "Popular"
    case favorites = "Favorites"
    case allStations = "AllStations"
    
    func viewController() -> UIViewController {
        switch self {
        case .popular:
            PopularController()
        case .favorites:
            PopularController()
        case .allStations:
            PopularController()
        }
    }
}

protocol VerticalTabBarPresenterProtocol: AnyObject {
    func loadViewController()
}

final class VerticalTabBarPresenter: VerticalTabBarPresenterProtocol {
    
    private unowned let tabBarController: VerticalTabBarControllerProtocol
    
    init(tabBarController: VerticalTabBarControllerProtocol) {
        self.tabBarController = tabBarController
    }
    
    func loadViewController() {
        ViewType.allCases.forEach { viewType in
            let title = NSLocalizedString(viewType.rawValue, comment: "Localizable")
            tabBarController.addTabBarButtons(title)
        }
    }
}
