//
//  FavoritesController.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 30.07.2024.
//

import UIKit

final class FavoritesController: UIViewController {

	private let favoritesView = FavoritesView()

	// MARK: - Life Cycle
	override func loadView() {
		view = favoritesView
		view.backgroundColor = Color.backgroundBlue
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		favoritesView.setDelegates(self)
	}


}

extension FavoritesController: FavoritesViewDelegate {
	func tappedButton() {
		print("Button is tapped")
	}

}


//@available(iOS 17, *)
//#Preview {
//	FavoritesController()
//}
