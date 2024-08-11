//
//  FavoriteCell.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 01.08.2024.
//

import UIKit

protocol FavoriteCellDelegate: AnyObject {
	func unliked(stationuuid: String)
}

final class FavoriteCell: UICollectionViewCell {

	weak var delegate: FavoriteCellDelegate?

	// MARK: - Station ID
	private lazy var stationuuid = ""

	// MARK: - Identifier
	static let identifier = FavoriteCell.description()

	// MARK: - UI
	private var genreLabel = UILabel.makeCustomLabelBold(
		key: nil,
		fontSize: 30,
		textColor: .white,
		numberOfLines: 1,
		textAligment: .left
	)
	private var nameLabel = UILabel.makeCustomLabel(
		key: nil,
		fontSize: 15,
		textColor: .white,
		numberOfLines: 1,
		textAligment: .left
	)
	private var waveView = WaveView(
		frame: .zero,
		dotColor: .red
	)
	private var likeButton = UIButton.makeCustomButtonWithImage(
		image: .heartBlue
	)

	// MARK: - Life Cycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setDelegates(_ value: FavoriteCellDelegate) {
		delegate = value
	}

	// MARK: - Setting Views
	private func setupView() {
		backgroundColor = .clear
		contentView.layer.borderWidth = 2
		contentView.layer.borderColor = Color.borderColor.cgColor
		contentView.layer.cornerRadius = 15

		likeButton.addTarget(
			self,
			action: #selector(dontLikeButtonTap),
			for: .touchUpInside
		)

		[
			genreLabel,
			nameLabel,
			waveView,
			likeButton
		].forEach { addSubview($0) }

		setupConstraints()
	}

	// MARK: - Constraints
	private func setupConstraints() {
		waveView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([

			nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

			genreLabel.topAnchor.constraint(equalTo: topAnchor, constant: 17),
			genreLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),
			genreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),

			waveView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
			waveView.leadingAnchor.constraint(equalTo: genreLabel.leadingAnchor),
			waveView.widthAnchor.constraint(equalToConstant: 80),
			waveView.heightAnchor.constraint(equalToConstant: 25),

			likeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
			likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

		])
	}

	// MARK: - Reusing a cell
	override func prepareForReuse() {
		super.prepareForReuse()
		nameLabel.text = nil
		genreLabel.text = nil
		waveView.setDotColor(color: .red)
		waveView.setNeedsDisplay()
	}

	// MARK: - Updating a cell
	func configure(model: Station) {
		stationuuid = model.stationuuid ?? ""
		genreLabel.text = model.tags?.components(separatedBy: CharacterSet(charactersIn: " ,")).first?.capitalized ?? "Unknown"
		nameLabel.text = model.name?.capitalized ?? "Unknown station"
	}
}

// MARK: - @objc method
extension FavoriteCell {
	@objc private func dontLikeButtonTap(){
		delegate?.unliked(stationuuid: stationuuid)
	}
}
