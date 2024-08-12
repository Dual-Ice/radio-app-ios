//
//  AllStationCell.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 11.08.2024.
//

import UIKit

protocol AllStationCellDelegate: AnyObject {
    func vote(for stationuuid: String)
}

final class AllStationCell: UICollectionViewCell {
    // MARK: - Identifier
    static let identifier = AllStationCell.description()

    private var stationUid: String = ""
    
    // MARK: - UI
    private let genreStation = UILabel.makeCustomLabelBold(
        key: "",
        fontSize: 15,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left
    )

    private let nameStation = UILabel.makeCustomLabel(
        key: "",
        fontSize: 25,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left
    )

    private let playingStatus = UILabel.makeCustomLabelBold(
        key: "Playing now",
        fontSize: 14,
        textColor: .darkGray,
        numberOfLines: 1,
        textAligment: .left
    )

    private let votesLabel = UILabel.makeCustomLabelBold(
        key: "",
        fontSize: 12,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .right
    )

    private let waveView = WaveView(
        frame: CGRect(x: 0, y: 0, width: 80, height: 23),
        dotColor: .red
    )
    
    private let votesButton = UIButton.makeCustomButtonWithImage(
        image: Image.heartDeselected
    )

    weak var delegate: AllStationCellDelegate?
    
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
        waveView.setDotColor(color: .red)
        waveView.setNeedsDisplay()
        updateAppearance(isActive: false)
    }

    // MARK: - Setting Views
    private func setupView() {
        contentView.backgroundColor = Color.backgroundBlue
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = Color.borderColor.cgColor
        contentView.layer.cornerRadius = 15
        self.layer.masksToBounds = true

        [
            genreStation,
            nameStation,
            playingStatus,
            votesLabel,
            waveView,
            votesButton
        ].forEach { addSubview($0) }
        
        votesButton.addTarget(self, action: #selector(votesButtonTapped), for: .touchUpInside)

        setupConstraints()
    }

    // MARK: - Constraints
    private func setupConstraints() {
        waveView.translatesAutoresizingMaskIntoConstraints = false
        votesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            votesButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            votesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            votesLabel.trailingAnchor.constraint(equalTo: votesButton.leadingAnchor, constant: -5),
            votesLabel.centerYAnchor.constraint(equalTo: votesButton.centerYAnchor),
            
            waveView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            waveView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            waveView.widthAnchor.constraint(equalToConstant: 90),
            waveView.heightAnchor.constraint(equalToConstant: 23),
            
            nameStation.topAnchor.constraint(equalTo: votesButton.bottomAnchor),
            nameStation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameStation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            genreStation.topAnchor.constraint(equalTo: nameStation.bottomAnchor, constant: 5),
            genreStation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            genreStation.trailingAnchor.constraint(equalTo: waveView.leadingAnchor, constant: -10),
            
            playingStatus.topAnchor.constraint(equalTo: genreStation.bottomAnchor, constant: 10),
            playingStatus.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            playingStatus.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    @objc private func votesButtonTapped() {
        delegate?.vote(for: stationUid)
    }
    
    private func updateAppearance(isActive: Bool) {
        if isActive {
            backgroundColor = Color.customPink
            layer.borderColor = Color.customPink.cgColor
            genreStation.textColor = .white
            nameStation.textColor = .white
            votesLabel.textColor = .white
            votesButton.tintColor = .white
            playingStatus.isHidden = false
            waveView.toggleWaveColor(active: true)
            return
        }
        backgroundColor = .clear
        layer.borderColor = Color.customGray.cgColor
        genreStation.textColor = Color.customGray
        nameStation.textColor = Color.customGray
        votesLabel.textColor = Color.customGray
        votesButton.tintColor = Color.customGray
        playingStatus.isHidden = true
        waveView.toggleWaveColor(active: false)
    }
    
    func configure(with stationData: StationData) {
        self.genreStation.text = stationData.genre
        self.nameStation.text = stationData.name
        self.waveView.setDotColor(color: stationData.dotColor)
        self.waveView.setNeedsDisplay()
        self.votesLabel.text = "votes: \(stationData.votes)"
        self.stationUid = stationData.id
        updateAppearance(isActive: stationData.isActive)
    }
    
    func setDelegate(_ value: AllStationCellDelegate) {
        delegate = value
    }
}
