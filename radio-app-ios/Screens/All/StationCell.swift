//
//  StationCell.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 08.08.2024.
//

import UIKit

protocol StationCellDelegate: AnyObject {
    func getStations() -> [StationModel]
}

final class StationCell: UICollectionViewCell {
    
    weak var delegate: StationCellDelegate?
    
    // MARK: - Identifier
    static let identifier = StationCell.description()
    
    // MARK: - UI
    var genreStation = UILabel.makeCustomLabelBold(
        key: "",
        fontSize: 30,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left
    )
    
    var nameStation = UILabel.makeCustomLabel(
        key: "",
        fontSize: 15,
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
        
        self.delegate = self
        
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
            
            genreStation.topAnchor.constraint(equalTo: topAnchor, constant: 17),
            genreStation.bottomAnchor.constraint(equalTo: nameStation.topAnchor, constant: -3),
            genreStation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            
            nameStation.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameStation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            playingStatus.topAnchor.constraint(equalTo: nameStation.bottomAnchor, constant: 17),
            playingStatus.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            votes.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            votes.trailingAnchor.constraint(equalTo: imageHeart.leadingAnchor, constant: -5),
            
            imageHeart.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            imageHeart.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            imageWave.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageWave.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            
        ])
    }
}

extension StationCell: StationCellDelegate {
    
    func getStations() -> [StationModel] {
        return [StationModel(radioTitle: "PopOne", genre: "Pop", isPlayingNow: false, votes: "340"),
                StationModel(radioTitle: "RockingHard", genre: "Rock", isPlayingNow: false, votes: "234"),
                StationModel(radioTitle: "DeepState", genre: "House", isPlayingNow: false, votes: "678")]
    }
}

