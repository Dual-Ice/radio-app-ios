//
//  PopularCell.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 01.08.2024.
//

import UIKit

final class PopularCell: UICollectionViewCell {
    
//    private let playButton = UIButton.makeCustomButtonWithImage(image: Image.playWhite)
    private let playImage = UIImageView.makeSimpleImage(imageName: "playWhite")
    private let votesLabel = UILabel.makeCustomLabelBold(key: "votes", fontSize: 10, textColor: .white, numberOfLines: 1, textAligment: .left)
    private let votesButton = UIButton.makeCustomButtonWithImage(image: Image.heartDeselected)
    private let genreLabel = UILabel.makeCustomLabelBold(key: "POP", fontSize: 22, textColor: .white, numberOfLines: 1, textAligment: .center)
    private let radioNameLabel = UILabel.makeCustomLabel(key: "Radio Record", fontSize: 12, textColor: .white, numberOfLines: 1, textAligment: .center)
    private let waveImageView = UIImageView()
    
    private var votes = 0
    private var hasVoted = false
    
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
        
        [playImage, votesLabel, votesButton, genreLabel, radioNameLabel, waveImageView].forEach { addSubview($0) }
    }
    
    private func layoutViews() {
        waveImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            playImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            playImage.widthAnchor.constraint(equalToConstant: 30),
            playImage.heightAnchor.constraint(equalToConstant: 30),
            
            votesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            votesButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            votesButton.widthAnchor.constraint(equalToConstant: 30),
            votesButton.heightAnchor.constraint(equalToConstant: 30),
            
            votesLabel.trailingAnchor.constraint(equalTo: votesButton.leadingAnchor, constant: 5),
            votesLabel.centerYAnchor.constraint(equalTo: votesButton.centerYAnchor),
            
            genreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            genreLabel.topAnchor.constraint(equalTo: playImage.bottomAnchor, constant: -5),
            
            radioNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            radioNameLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: -10),
            
            waveImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            waveImageView.topAnchor.constraint(equalTo: radioNameLabel.bottomAnchor, constant: 10),
            waveImageView.widthAnchor.constraint(equalToConstant: 94),
            waveImageView.heightAnchor.constraint(equalToConstant: 23),
            waveImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    @objc private func votesButtonTapped() {
        if hasVoted {
            hasVoted = false
            votes -= 1
            votesButton.setImage(UIImage(named: "heartDeselected"), for: .normal)
        } else {
            hasVoted = true
            votes += 1
            votesButton.setImage(UIImage(named: "heartSelected"), for: .normal)
        }
        updateVotesLabel()
    }
    
    private func updateVotesLabel() {
        votesLabel.text = "votes \(votes)"
    }
    
    private func configureGenreLabelText(_ text: String) -> String {
        return text.components(separatedBy: ",").first?.components(separatedBy: " ").prefix(2).joined(separator: " ") ?? text
    }
    
    func configure(with title: String, subtitle: String, votes: Int, isActive: Bool, waveImage: UIImage) {
        self.genreLabel.text = configureGenreLabelText(title)
        self.radioNameLabel.text = subtitle
        self.votes = votes
        self.hasVoted = false
        self.waveImageView.image = waveImage
        
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
            waveImageView.alpha = 1
            return
        }
        backgroundColor = .clear
        layer.borderColor = Color.customGray.cgColor
        genreLabel.textColor = Color.customGray
        radioNameLabel.textColor = Color.customGray
        votesLabel.textColor = Color.customGray
        votesButton.tintColor = Color.customGray
        playImage.isHidden = true
        waveImageView.alpha = 0.5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playImage.image = Image.playWhite
        hasVoted = false
        votes = 0
        waveImageView.image = Image.waveRed
        updateVotesLabel()
        updateAppearance(isActive: false)
    }
}
