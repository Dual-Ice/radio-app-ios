//
//  FavoriteBuilder.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 11.08.2024.
//
import UIKit

final class FavoritesBuilder {
    static func buildFavoritesController(_ navigationController: UINavigationController) -> UIViewController {
        let router = FavoritesRouter(navigationController)
        let presenter = FavoritesPresenter(favoritesRouter: router)
        let vc = FavoritesController(presenter: presenter)
        presenter.favoritesVC = vc
        
        return vc
    }
}
