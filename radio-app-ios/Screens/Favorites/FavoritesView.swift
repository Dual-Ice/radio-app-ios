//
//  FavoritesView.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 30.07.2024.
//

import UIKit

final class FavoritesView: UIView {

	// MARK: - UICollection
	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.estimatedItemSize.width = 291
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 16

		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.translatesAutoresizingMaskIntoConstraints = false
		cv.backgroundColor = .clear
		cv.showsVerticalScrollIndicator = false
		cv.alwaysBounceVertical = true

		cv.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.identifier)

		return cv
	}()

	// MARK: - Life Cycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Setting Views
	private func setupViews(){
		backgroundColor = Color.backgroundBlue

		addSubview(collectionView)
		setupConstraints()
	}

	// MARK: - Constraints
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
			collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 200),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -230)
		])
	}
}
