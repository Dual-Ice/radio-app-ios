//
//  UIImageView_Extension.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 01.08.2024.
//

import UIKit

extension UIImageView {

	static func makeImageHeartView(resource: UIImage) -> UIImageView {
		let imageView = UIImageView()
		imageView.image = resource
		imageView.layer.masksToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}
}
