//
//  FavoritesView.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 30.07.2024.
//

import UIKit

protocol FavoritesViewDelegate: AnyObject {
	func tappedButton()
}

final class FavoritesView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

	weak var delegate: FavoritesViewDelegate?

	// MARK: - UICollection
	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.estimatedItemSize.width = 291
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 16

		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = .clear
		cv.showsVerticalScrollIndicator = false
		cv.alwaysBounceVertical = true

		cv.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.identifier)

		return cv
	}()

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		30
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else {
			return UICollectionViewCell()
		}
		//		cell.configure(model: ?)
		return cell
	}

	// MARK: - Life Cycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		collectionView.delegate = self
		collectionView.dataSource = self
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setDelegates(_ value: FavoritesController) {
		delegate = value
	}

	private func setupViews(){
		backgroundColor = .clear
		addSubview(collectionView)
		setupConstraints()
	}

	private func setupConstraints() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false // temp

		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
			collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 200),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -230)
		])
	}

	@objc private func buttonTapped(){
		delegate?.tappedButton()
	}
}


//@available(iOS 17, *)
//#Preview {
//	FavoritesView()
//}
