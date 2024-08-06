//
//  FavoritesController.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 30.07.2024.
//

import UIKit

final class FavoritesController: UIViewController {

	private let favoritesView = FavoritesView()
	private let favoriteCell = FavoriteCell()

	// MARK: - Life Cycle
	override func loadView() {
		view = favoritesView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		favoriteCell.delegate = self
		favoritesView.collectionView.dataSource = self
	}
}


extension FavoritesController: FavoriteCellDelegate {
	func tappedButton() {
		print("Button is tapped")
	}
}

extension FavoritesController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		30 // test
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else {
			return UICollectionViewCell()
		}
		//		cell.configure(model: Station)
		return cell
	}
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
	FavoritesController()
}
