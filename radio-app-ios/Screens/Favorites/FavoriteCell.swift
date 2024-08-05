//
//  FavoriteCell.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 01.08.2024.
//

import UIKit

final class FavoriteCell: UICollectionViewCell {

	static let identifier = "favoriteCell"

	// MARK: - UI
	private lazy var genreStation = UILabel()
	private lazy var nameStation = UILabel()
	private lazy var imageWave = UIImageView()
	private lazy var imageHeart = UIImageView()

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
		contentView.layer.borderColor = #colorLiteral(red: 0.2560741901, green: 0.2609855533, blue: 0.3792468607, alpha: 1)
		contentView.layer.cornerRadius = 15

		genreStation = UILabel.makeCustomLabelBold(
			key: "POP", // test
			fontSize: 30,
			textColor: .white,
			numberOfLines: 1,
			textAligment: .left
		)
		nameStation = UILabel.makeCustomLabel(
			key: "Radio Record", // test
			fontSize: 15,
			textColor: .white,
			numberOfLines: 1,
			textAligment: .left
		)
		imageWave = UIImageView.makeImageHeartView(
			resource: .waveRed // test
		)
		imageHeart = UIImageView.makeImageHeartView(
			resource: .heartBlue
		)

		[
			genreStation,
			nameStation,
			imageWave,
			imageHeart
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

			imageHeart.centerYAnchor.constraint(equalTo: centerYAnchor),
			imageHeart.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

		])
	}

	// MARK: - Updating a cell with data obtained from models
//	func configure(model: ?) { // temp: String
//				genreStation.text = model.
//				nameStation.text = model.
//
//	}

}


//@available(iOS 17, *)
//#Preview {
//	FavoriteCell()
//}
