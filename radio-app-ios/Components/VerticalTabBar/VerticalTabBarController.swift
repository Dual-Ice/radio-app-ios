//
//  VerticalTabBarController.swift
//  radio-app-ios
//
//  Created by nik on 30.07.24.
//

import UIKit

protocol VerticalTabBarControllerProtocol: AnyObject {
    func showView(_ viewController: ViewType)
    func addTabBarButtons(_ title: String)
}

final class VerticalTabBarController: UIViewController {
    
    private let verticalTabBar = VerticalTabBar()
    private var currentViewController: UIViewController?
    
    var presenter: VerticalTabBarPresenterProtocol?
    
    override func loadView() {
        view = verticalTabBar
        presenter?.loadViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verticalTabBar.delegate = self
    }
}

extension VerticalTabBarController: VerticalTabBarControllerProtocol {
    func addTabBarButtons(_ title: String) {
        verticalTabBar.addTabBarButton(title)
    }
    
    func showView(_ viewController: ViewType) {
        currentViewController = viewController.viewController()
        verticalTabBar.showView(currentViewController?.view ?? UIView())
    }
}

extension VerticalTabBarController: VerticalTabBarDelegate {
    func didSelectTab(_ sender: UIButton) {
        print("VerticalTabBarController: VerticalTabBarDelegate -> didSelectTab(at index: \(sender.titleLabel?.text)")
    }
}
