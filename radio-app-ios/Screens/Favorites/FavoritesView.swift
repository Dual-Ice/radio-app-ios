//
//  FavoritesView.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 30.07.2024.
//

import UIKit

protocol FavoritesViewDelegate: AnyObject {
	func profileTapped()
}

final class FavoritesView: UIView {

	weak var delegate: FavoritesViewDelegate?

	// MARK: - UI
	private lazy var playerView = PlayerControlView()
	//	private lazy var volumeSlider = VolumeControlView()

	private let playImageView = UIImageView.makeSimpleImage(
		imageName: "playPink"
	)

	private let greetingLabel = UILabel.makeCustomLabelBold(
		key: "Hello",
		fontSize: 26,
		textColor: .white,
		numberOfLines: 1,
		textAligment: .left
	)

	private let usernameLabel = UILabel.makeCustomLabelBold(
		key: "User", // test preview
		fontSize: 26,
		textColor: Color.customPink,
		numberOfLines: 1,
		textAligment: .left
	)

	private var profileImageView = RoundedTriangleImageView(
		frame: CGRect(x: 0, y: 0, width: 70, height: 65),
		radius: 15
	)

	private let titleLabel = UILabel.makeCustomLabel(
		key: "Favorites",
		fontSize: 30,
		textColor: .white,
		numberOfLines: 1,
		textAligment: .left
	)

	// MARK: - UICollection
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: 270, height: 123)
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 15

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

	// MARK: - Delegates
	func setDelegates(_ delegate: FavoritesController) {
		collectionView.delegate = delegate
		collectionView.dataSource = delegate
	}

	// MARK: - Setting Views
	private func setupViews(){
		backgroundColor = Color.backgroundBlue

		[
			playerView,
			playImageView,
			greetingLabel,
			usernameLabel,
			profileImageView,
			titleLabel,
			collectionView,
		].forEach { addSubview($0) }

		setupConstraints()
	}

	// MARK: - Constraints
	private func setupConstraints() {
		playerView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			playImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
			playImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			playImageView.widthAnchor.constraint(equalToConstant: 33),
			playImageView.heightAnchor.constraint(equalToConstant: 33),

			greetingLabel.leadingAnchor.constraint(equalTo: playImageView.trailingAnchor, constant: 10),
			greetingLabel.centerYAnchor.constraint(equalTo: playImageView.centerYAnchor),

			usernameLabel.leadingAnchor.constraint(equalTo: greetingLabel.trailingAnchor, constant: 5),
			usernameLabel.centerYAnchor.constraint(equalTo: greetingLabel.centerYAnchor),

			profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
			profileImageView.widthAnchor.constraint(equalToConstant: 60),
			profileImageView.heightAnchor.constraint(equalToConstant: 60),

			titleLabel.topAnchor.constraint(equalTo: playImageView.bottomAnchor, constant: 28),
			titleLabel.leadingAnchor.constraint(equalTo: greetingLabel.leadingAnchor),

			collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -255),

			playerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -70),
			playerView.centerXAnchor.constraint(equalTo: centerXAnchor),
			playerView.widthAnchor.constraint(equalToConstant: 255),
			playerView.heightAnchor.constraint(equalToConstant: 125),
		])
	}

	private func setupActions() {
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
		profileImageView.addGestureRecognizer(tapGestureRecognizer)
		profileImageView.isUserInteractionEnabled = true
	}

	func configureProfile(username: String, profileImage: UIImage) {
		usernameLabel.text = username
		profileImageView.setImage(profileImage)
	}
}

// MARK: - @objc method
extension FavoritesView {
	@objc private func profileTapped() {
		delegate?.profileTapped()
	}
}
