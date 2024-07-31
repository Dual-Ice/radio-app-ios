//
//  VerticalTabBarController.swift
//  radio-app-ios
//
//  Created by nik on 30.07.24.
//

import UIKit

protocol VerticalTabBarControllerProtocol: AnyObject {
    func showView(_ viewController: ViewType)
    func addTabBarButtons(_ title: String, identifier: ViewType)
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
    func addTabBarButtons(_ title: String, identifier: ViewType) {
        verticalTabBar.addTabBarButton(title, identifier: identifier)
    }
    
    func showView(_ viewController: ViewType) {
        children.forEach { children in
            children.view.removeFromSuperview()
            children.removeFromParent()
        }
        
        let vc = viewController.viewController()
        
        print(vc)
        
        addChild(vc)
        vc.view.frame = verticalTabBar.viewContainer.bounds
        verticalTabBar.viewContainer.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
}

extension VerticalTabBarController: VerticalTabBarDelegate {
    func didSelectTab(_ sender: CustomTabBarButton) {
        verticalTabBar.buttons.forEach { button in
            button.setActive(button == sender)
        }
        
        presenter?.didChooseView(sender.buttonIdentifier)
    }
}
