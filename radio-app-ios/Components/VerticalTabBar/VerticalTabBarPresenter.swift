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
            testVC1()
        case .favorites:
            testVC2()
        case .allStations:
            testVC3()
        }
    }
}

protocol VerticalTabBarPresenterProtocol: AnyObject {
    func loadViewController()
    func didChooseView(_ view: ViewType)
}

final class VerticalTabBarPresenter: VerticalTabBarPresenterProtocol {
    private unowned let tabBarController: VerticalTabBarControllerProtocol
        
    init(tabBarController: VerticalTabBarControllerProtocol) {
        self.tabBarController = tabBarController
    }
    
    func loadViewController() {
        ViewType.allCases.forEach { viewType in
            let title = NSLocalizedString(viewType.rawValue, comment: "Localizable")
            tabBarController.addTabBarButtons(title, identifier: viewType)
        }
    }
    
    func didChooseView(_ view: ViewType) {
        tabBarController.showView(view)
    }
}

class testVC1: UIViewController {
    override func loadView() {
        let testView = UIView()
        testView.backgroundColor = .green
        let label = UILabel()
        label.text = "testVC1"
        label.translatesAutoresizingMaskIntoConstraints = false
        testView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: testView.centerYAnchor)
        ])
        view = testView
    }
}

class testVC2: UIViewController {
    override func loadView() {
        let testView = UIView()
        testView.backgroundColor = .systemPink
        let label = UILabel()
        label.text = "testVC2"
        label.translatesAutoresizingMaskIntoConstraints = false
        testView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: testView.centerYAnchor)
        ])
        view = testView
    }
}

class testVC3: UIViewController {
    override func loadView() {
        let testView = UIView()
        testView.backgroundColor = .blue
        let label = UILabel()
        label.text = "testVC3"
        label.translatesAutoresizingMaskIntoConstraints = false
        testView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: testView.centerYAnchor)
        ])
        view = testView
    }
}
