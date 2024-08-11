//
//  FavoritesPresenter.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 10.08.2024.
//

import UIKit

final class FavoritesPresenter {

	weak var favoritesVC: FavoritesController?

	private let favoritesRouter: FavoritesRouter
	private lazy var stations = [Station]()

	private var favoriteStations: Set<String> = []

	init(favoritesRouter: FavoritesRouter) {
		self.favoritesRouter = favoritesRouter
	}

	func goToDetail(index: Int) {
		favoritesRouter.goToDetail(station: stations[index])
	}

	func getStations() -> [Station] {
		return stations
	}

	func onWillAppear(completion: @escaping () -> Void) {
		loadFavoriteStations(completion: completion)
	}

	private func loadFavoriteStations(completion: @escaping () -> Void) {
		UserManager.shared.getFavoriteStations { [weak self] (stations, error) in
			if let error = error {
				print("Failed to fetch favorite stations: \(error)")
				completion()
				return
			}

			self?.favoriteStations = Set(stations.map { $0.stationuuid ?? "" })
			completion()
		}
	}
}
