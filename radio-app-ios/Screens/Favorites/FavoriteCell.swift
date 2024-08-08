//
//  FavoriteCell.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 01.08.2024.
//

import UIKit

protocol FavoriteCellDelegate: AnyObject {
	func tappedButton()
}

final class FavoriteCell: UICollectionViewCell {

	weak var delegate: FavoriteCellDelegate?

	// MARK: - Identifier
	static let identifier = FavoriteCell.description()

	// MARK: - UI
	private var genreStation = UILabel.makeCustomLabelBold(
		key: "POP", // test
		fontSize: 30,
		textColor: .white,
		numberOfLines: 1,
		textAligment: .left
	)

	private var nameStation = UILabel.makeCustomLabel(
		key: "Radio Record", // test
		fontSize: 15,
		textColor: .white,
		numberOfLines: 1,
		textAligment: .left
	)

	private var imageWave = UIImageView.makeSimpleImage(
		imageName: "waveRed" // test
	)

	private var buttonHeart = UIButton.makeCustomButtonWithHeart()

	// MARK: - Life Cycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Reusing a cell
	override func prepareForReuse() {
		super.prepareForReuse()
		nameStation.text = nil
		genreStation.text = nil
		imageWave.image = nil
	}

	// MARK: - Setting Views
	private func setupView() {
		backgroundColor = .clear
		contentView.layer.borderWidth = 2
		contentView.layer.borderColor = Color.cellBorder.cgColor
		contentView.layer.cornerRadius = 15

		buttonHeart.addTarget(
			self, 
			action: #selector(buttonTapped),
			for: .touchUpInside
		)

		[
			genreStation,
			nameStation,
			imageWave,
			buttonHeart
		].forEach { addSubview($0) }

		setupConstraints()
	}

	// MARK: - Constraints
	private func setupConstraints() {
		NSLayoutConstraint.activate([

			nameStation.centerYAnchor.constraint(equalTo: centerYAnchor),
			nameStation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

			genreStation.topAnchor.constraint(equalTo: topAnchor, constant: 17),
			genreStation.bottomAnchor.constraint(equalTo: nameStation.topAnchor, constant: -3),
			genreStation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),

			imageWave.topAnchor.constraint(equalTo: nameStation.bottomAnchor, constant: 10),
			imageWave.leadingAnchor.constraint(equalTo: genreStation.leadingAnchor),

			buttonHeart.centerYAnchor.constraint(equalTo: centerYAnchor),
			buttonHeart.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

		])
	}

	// MARK: - Updating a cell with data obtained from models
//	func configure(model: Station) {
//				genreStation.text = model.
//				nameStation.text = model.
//
//	}
}


extension FavoriteCell {
	func setDelegates(_ value: FavoritesController) {
		delegate = value
	}

	// MARK: - @objc method
	@objc private func buttonTapped(){
		delegate?.tappedButton()
	}
}
