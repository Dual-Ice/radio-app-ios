//
//  AllStationCell.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 11.08.2024.
//

import UIKit

final class AllStationCell: UICollectionViewCell {

    // MARK: - Identifier
    static let identifier = AllStationCell.description()

    // MARK: - UI
    var genreStation = UILabel.makeCustomLabelBold(
        key: "",
        fontSize: 15,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left
    )

    var nameStation = UILabel.makeCustomLabel(
        key: "",
        fontSize: 25,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left
    )

    var playingStatus = UILabel.makeCustomLabelBold(
        key: "Playing now",
        fontSize: 14,
        textColor: .darkGray,
        numberOfLines: 1,
        textAligment: .left
    )

    var votes = UILabel.makeCustomLabelBold(
        key: "",
        fontSize: 12,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left
    )

    var imageWave = UIImageView.makeSimpleImage(
        imageName: "waveRed"
    )


    var imageHeart = UIImageView.makeSimpleImage(
        imageName: "heartSelected"
    )

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
    }

    // MARK: - Setting Views
    private func setupView() {
        contentView.backgroundColor = Color.customPink
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = Color.customPink.cgColor
        contentView.layer.cornerRadius = 15


        [
            genreStation,
            nameStation,
            playingStatus,
            votes,
            imageWave,
            imageHeart
        ].forEach { addSubview($0) }

        setupConstraints()
    }

    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([

            nameStation.topAnchor.constraint(equalTo: topAnchor, constant: 30),//17
            nameStation.bottomAnchor.constraint(equalTo: genreStation.topAnchor, constant: -3),
            nameStation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -10),

            genreStation.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10), //0
            genreStation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            playingStatus.topAnchor.constraint(equalTo: genreStation.bottomAnchor, constant: 10), //17
            playingStatus.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            votes.topAnchor.constraint(equalTo: topAnchor, constant: 13),//13
            votes.trailingAnchor.constraint(equalTo: imageHeart.leadingAnchor, constant: -5),

            imageHeart.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            imageHeart.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            imageWave.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 30),
            imageWave.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)

        ])
    }
}
