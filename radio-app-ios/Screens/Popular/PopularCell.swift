//
//  PopularCell.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 01.08.2024.
//

import UIKit

protocol PopularCellDelegate: AnyObject {
    func vote(for stationuuid: String)
}

final class PopularCell: UICollectionViewCell {
    static let identifier = PopularCell.debugDescription()
    private var stationUid: String = .init()
    
    weak var delegate: PopularCellDelegate?
    
    private let playImage = UIImageView.makeSimpleImage(imageName: "playWhite")
    private let votesLabel = UILabel.makeCustomLabelBold(key: "votes", fontSize: 10, textColor: .white, numberOfLines: 0, textAligment: .left, wrapText: true)
    private let votesButton = UIButton.makeCustomButtonWithImage(image: Image.heartDeselected)
    private let genreLabel = UILabel.makeCustomLabelBold(key: "POP", fontSize: 22, textColor: .white, numberOfLines: 1, textAligment: .center)
    private let radioNameLabel = UILabel.makeCustomLabel(key: "Radio Record", fontSize: 11, textColor: .white, numberOfLines: 1, textAligment: .center)
    private let waveView = WaveView(frame: CGRect(x: 0, y: 0, width: 80, height: 23), dotColor: .red)
    
    private var votes = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegate(_ value: PopularCellDelegate) {
        delegate = value
    }
    
    private func setViews() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = Color.customGray.cgColor
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
        
        votesButton.addTarget(self, action: #selector(votesButtonTapped), for: .touchUpInside)
        
        [playImage, votesLabel, votesButton, genreLabel, radioNameLabel, waveView].forEach { addSubview($0) }
    }
    
    private func layoutViews() {
        waveView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            playImage.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            playImage.widthAnchor.constraint(equalToConstant: 25),
            playImage.heightAnchor.constraint(equalToConstant: 25),
            
            votesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            votesButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            votesButton.widthAnchor.constraint(equalToConstant: 30),
            votesButton.heightAnchor.constraint(equalToConstant: 30),
            
            votesLabel.trailingAnchor.constraint(equalTo: votesButton.leadingAnchor, constant: 5),
            votesLabel.centerYAnchor.constraint(equalTo: votesButton.centerYAnchor),
            
            genreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            genreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            genreLabel.topAnchor.constraint(equalTo: playImage.bottomAnchor, constant: -30),
            
            radioNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            radioNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            radioNameLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: -30),
            
            waveView.centerXAnchor.constraint(equalTo: centerXAnchor),
            waveView.topAnchor.constraint(equalTo: radioNameLabel.bottomAnchor, constant: 10),
            waveView.widthAnchor.constraint(equalToConstant: 80),
            waveView.heightAnchor.constraint(equalToConstant: 23),
            waveView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    @objc private func votesButtonTapped() {
        delegate?.vote(for: stationUid)
    }
    
    private func updateVotesLabel(isActive: Bool) {
        let votesText = "\(NSLocalizedString("votes", comment: "")) \(votes)"
        let finalText = isActive ? "\(NSLocalizedString("votes", comment: ""))\n\(votes)" : votesText
        
        votesLabel.text = finalText
    }
    
    func configure(with stationData: StationData) {
        self.genreLabel.text = stationData.genre
        self.radioNameLabel.text = stationData.name
        self.votes = stationData.votes
        self.waveView.setDotColor(color: stationData.dotColor)
        self.waveView.setNeedsDisplay()
        self.stationUid = stationData.id
        updateVotesLabel(isActive: stationData.isActive)
        updateAppearance(isActive: stationData.isActive)
        updateFavorite(isFavorite: stationData.isFavorite)
    }
    
    private func updateFavorite(isFavorite: Bool) {
       let imageName = isFavorite
            ? "heartSelected"
            : "heartDeselected"
        votesButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    private func updateAppearance(isActive: Bool) {
        if isActive {
            backgroundColor = Color.customPink
            layer.borderColor = Color.customPink.cgColor
            genreLabel.textColor = .white
            radioNameLabel.textColor = .white
            votesLabel.textColor = .white
            votesButton.tintColor = .white
            playImage.isHidden = false
            waveView.toggleWaveColor(active: true)
            return
        }
        backgroundColor = .clear
        layer.borderColor = Color.customGray.cgColor
        genreLabel.textColor = Color.customGray
        radioNameLabel.textColor = Color.customGray
        votesLabel.textColor = Color.customGray
        votesButton.tintColor = Color.customGray
        playImage.isHidden = true
        waveView.toggleWaveColor(active: false)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        votes = 0
        stationUid = ""
        waveView.setDotColor(color: .red)
        waveView.toggleWaveColor(active: false)
        waveView.setNeedsDisplay()
        updateVotesLabel(isActive: false)
        updateAppearance(isActive: false)
    }
}
