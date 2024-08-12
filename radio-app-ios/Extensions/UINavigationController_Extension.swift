//
//  UINavigationController_Extension.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 11.08.2024.
//

import UIKit

extension UINavigationController {

    func setNavigationBar(for viewController: UIViewController, title: String) {

        /// title
        viewController.navigationItem.title = title
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]

        /// left item
        viewController.navigationItem.hidesBackButton = false
        let backButton = UIBarButtonItem(image: Image.arrowBack,
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        backButton.tintColor = .white
        viewController.navigationItem.leftBarButtonItem = backButton

        /// right item
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let profileImage = RoundedTriangleImageView(
            frame: CGRect(x: 0,
                          y: 0,
                          width: 50,
                          height: 50),
            radius: 10)
        profileImage.setImage(UIImage(systemName: "person.fill") ?? UIImage())
        containerView.addSubview(profileImage)
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: containerView)
    }

    @objc func backButtonTapped() {
        popViewController(animated: true)
    }
}
