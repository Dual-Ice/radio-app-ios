//
//  FavoritesBuilder.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 10.08.2024.
//

import UIKit

final class PopularBuilder {
	static func buildFavoritesController(_ navigationController: UINavigationController) -> UIViewController {
		let router = FavoritesRouter(navigationController)
		let presenter = FavoritesPresenter(favoritesRouter: router)
		let vc = FavoritesController(presenter: presenter)
		presenter.favoritesVC = vc

		return vc
	}
}
