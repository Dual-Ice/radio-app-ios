//
//  FavoritesController.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 30.07.2024.
//

import UIKit

final class FavoritesController: UIViewController {

	let presenter: FavoritesPresenter

	init(presenter: FavoritesPresenter) {
		self.presenter = presenter
		super.init()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private lazy var favoritesView = FavoritesView()
	private lazy var stations = [Station]()


	// MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view = favoritesView
		navigationController?.navigationBar.isHidden = true
		favoritesView.setDelegates(self)

	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
	}

	private func deleteStation(stationuuid: String) {
		// code
		print("Station deleted from Favorites")
	}
}

// MARK: - Extensions
extension FavoritesController: FavoriteCellDelegate {
	func unliked(stationuuid: String) {
		deleteStation(stationuuid: stationuuid)
	}
}

extension FavoritesController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		stations.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else {
			return UICollectionViewCell()
		}
		cell.configure(model: stations[indexPath.row])
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
}
