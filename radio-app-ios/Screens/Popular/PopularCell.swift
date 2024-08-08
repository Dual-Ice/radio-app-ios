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
    
    weak var delegate: PopularCellDelegate?
    
    private let playImage = UIImageView.makeSimpleImage(imageName: "playWhite")
    private let votesLabel = UILabel.makeCustomLabelBold(key: "votes", fontSize: 10, textColor: .white, numberOfLines: 1, textAligment: .left)
    private let votesButton = UIButton.makeCustomButtonWithImage(image: Image.heartDeselected)
    private let genreLabel = UILabel.makeCustomLabelBold(key: "POP", fontSize: 22, textColor: .white, numberOfLines: 1, textAligment: .center)
    private let radioNameLabel = UILabel.makeCustomLabel(key: "Radio Record", fontSize: 11, textColor: .white, numberOfLines: 1, textAligment: .center)
    private let waveView = WaveView(frame: CGRect(x: 0, y: 0, width: 94, height: 23), dotColor: .red)
    
    private var votes = 0
    private var hasVoted = false
    private var stationuuid: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            playImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            playImage.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            playImage.widthAnchor.constraint(equalToConstant: 25),
            playImage.heightAnchor.constraint(equalToConstant: 25),
            
            votesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            votesButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            votesButton.widthAnchor.constraint(equalToConstant: 30),
            votesButton.heightAnchor.constraint(equalToConstant: 30),
            
            votesLabel.trailingAnchor.constraint(equalTo: votesButton.leadingAnchor, constant: 5),
            votesLabel.centerYAnchor.constraint(equalTo: votesButton.centerYAnchor),
            
            genreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            genreLabel.topAnchor.constraint(equalTo: playImage.bottomAnchor, constant: -30),
            
            radioNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            radioNameLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: -30),
            
            waveView.centerXAnchor.constraint(equalTo: centerXAnchor),
            waveView.topAnchor.constraint(equalTo: radioNameLabel.bottomAnchor, constant: 10),
            waveView.widthAnchor.constraint(equalToConstant: 94),
            waveView.heightAnchor.constraint(equalToConstant: 23),
            waveView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    @objc private func votesButtonTapped() {
        if !hasVoted {
            hasVoted = true
            votes += 1
            votesButton.setImage(UIImage(named: "heartSelected"), for: .normal)
            updateVotesLabel()
            if let stationuuid = stationuuid {
                delegate?.vote(for: stationuuid)
            }
        }
    }
    
    private func updateVotesLabel() {
        votesLabel.text = String(format: NSLocalizedString("votes", comment: ""), votes)
    }
    
    private func configureGenreLabelText(_ text: String) -> String {
        return text.components(separatedBy: ",").first?.components(separatedBy: " ").prefix(2).joined(separator: " ") ?? text
    }
    
    func configure(with title: String, subtitle: String, votes: Int, isActive: Bool, dotColor: UIColor) {
        self.genreLabel.text = configureGenreLabelText(title)
        self.radioNameLabel.text = subtitle
        self.votes = votes
        self.hasVoted = false
        self.waveView.setDotColor(color: dotColor)
        self.waveView.setNeedsDisplay() // Обновляем отображение цвета точки
        
        updateVotesLabel()
        updateAppearance(isActive: isActive)
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
        playImage.image = nil
        hasVoted = false
        votes = 0
        waveView.setDotColor(color: .red)
        waveView.toggleWaveColor(active: false)
        waveView.setNeedsDisplay()
        updateVotesLabel()
        updateAppearance(isActive: false)
    }
}
