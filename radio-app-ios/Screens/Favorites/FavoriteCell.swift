//
//  FavoriteCell.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 01.08.2024.
//

import UIKit

protocol FavoriteCellDelegate: AnyObject {
    func tappedButtonWith(stationUid: String)
}

final class FavoriteCell: UICollectionViewCell {

    weak var delegate: FavoriteCellDelegate?

    // MARK: - Identifier
    static let identifier = FavoriteCell.description()
    
    
    private var stationUid: String = .init()
    // MARK: - UI
    private var genreStation = UILabel.makeCustomLabelBold(
        key: "POP",
        fontSize: 30,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left
    )

    private var nameStation = UILabel.makeCustomLabel(
        key: "Radio Record",
        fontSize: 15,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left
    )
    
    private let waveView = WaveView(frame: CGRect(x: 0, y: 0, width: 90, height: 23), dotColor: .red)

    private var buttonHeart = UIButton.makeCustomButtonWithImage(image: .heartBlue)

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
        stationUid = ""
        nameStation.text = nil
        genreStation.text = nil
        waveView.setDotColor(color: .red)
        waveView.setNeedsDisplay()
    }
    
    func setDelegate(_ value: FavoriteCellDelegate) {
        delegate = value
    }

    // MARK: - Setting Views
    private func setupView() {
        backgroundColor = .clear
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = Color.borderColor.cgColor
        contentView.layer.cornerRadius = 15

        buttonHeart.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )

        [
            genreStation,
            nameStation,
            waveView,
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

            waveView.topAnchor.constraint(equalTo: nameStation.bottomAnchor, constant: 10),
            waveView.leadingAnchor.constraint(equalTo: genreStation.leadingAnchor),
            waveView.widthAnchor.constraint(equalToConstant: 90),
            waveView.heightAnchor.constraint(equalToConstant: 23),
            
            buttonHeart.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonHeart.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

        ])
    }
    
    func configure(with stationData: FavoriteStationData) {
        self.genreStation.text = stationData.genre
        self.nameStation.text = stationData.name
        self.waveView.setDotColor(color: stationData.dotColor)
        self.waveView.setNeedsDisplay()
        self.stationUid = stationData.id
    }
}


extension FavoriteCell {
    func setDelegates(_ value: FavoritesController) {
        delegate = value
    }

    // MARK: - @objc method
    @objc private func buttonTapped(){
        delegate?.tappedButtonWith(stationUid: stationUid)
    }
}
