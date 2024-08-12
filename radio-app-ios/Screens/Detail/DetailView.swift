//
//  DetailView.swift
//  radio-app-ios
//
//  Created by Maksim on 30.07.2024.
//

import UIKit

protocol DetailViewDelegate: AnyObject {
    func addFavoriteButtonTapped()
    func arrowButtonTapped()
    func profileButtonTapped()
}

final class DetailView: UIView {
    // MARK: - UI Properties
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.backgroundColor = .black
        element.image = Image.signInBackground
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var headerStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fillProportionally
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var arrowButton: UIButton = UIButton.makeCustomButtonWithImage(image: Image.arrowBack!)
    
    private lazy var profileImageView = RoundedTriangleImageView(
        frame: CGRect(x: 0, y: 0, width: 50, height: 50),
        radius: 10
    )

    private let headerLabel = UILabel.makeCustomLabelBold(
        key: "PlayingNow",
        fontSize: 20,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .center)

    lazy var addFavoriteButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(systemName: "heart"), for: .normal)
        element.tintColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var radioFaviconImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "waveform.circle")
        element.tintColor = .white
        element.layer.cornerRadius = 35
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let stationFrequency = UILabel.makeCustomLabelBold(
        key: nil,
        fontSize: 60,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .center)
    
    private let stationTitle = UILabel.makeCustomLabel(
        key: nil,
        fontSize: 20,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .center)
    
    let playerControler = PlayerControlView()
    let volumeControler = VolumeControlView()
    
    let waveAnimationView = VerticalWaveAnimationView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))

    weak var delegate: DetailViewDelegate?

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegates(detailVD: DetailViewDelegate, playerVD: PlayerControlDelegate) {
        delegate = detailVD
        playerControler.delegate = playerVD
    }
    
    func configureUI(with stationData: Station, isFavorite: Bool) {
        radioFaviconImageView.getImage(from: URL(string: stationData.favicon ?? ""))
        stationTitle.text = stationData.name
        stationFrequency.text = stationData.freq
        
        addFavoriteButton.setImage(UIImage(systemName: isFavorite ? "heart.fill" : "heart"), for: .normal)
    }
    
    func setUserAvatar(_ image: UIImage?) {
        if let userAvatar = image {
            profileImageView.setImage(userAvatar)
        }
    }
    
    // MARK: - Private Methods
    private func setViews() {
        waveAnimationView.translatesAutoresizingMaskIntoConstraints = false
        
        [
            backgroundImageView,
            waveAnimationView,
            headerStackView,
            addFavoriteButton,
            radioFaviconImageView,
            stationFrequency,
            stationTitle,
            playerControler,
            volumeControler
        ].forEach { addSubview($0) }
        
        headerStackView.addArrangedSubview(arrowButton)
        headerStackView.addArrangedSubview(headerLabel)
        headerStackView.addArrangedSubview(profileImageView)
        
        setUpViews()
    }
    
    private func setUpViews(){
        addFavoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        arrowButton.addTarget(self, action: #selector(arrowButtonTap), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileTap))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor),
            
            headerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sideForHeader),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideForHeader),
            
            arrowButton.widthAnchor.constraint(equalToConstant: Constants.profileImageSize),
            arrowButton.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),

            profileImageView.widthAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),
            
            addFavoriteButton.bottomAnchor.constraint(equalTo: stationFrequency.topAnchor, constant: 10),
            addFavoriteButton.leadingAnchor.constraint(equalTo: stationFrequency.trailingAnchor),
            addFavoriteButton.widthAnchor.constraint(equalToConstant: 20),
            addFavoriteButton.heightAnchor.constraint(equalToConstant: 20),
            
            stationFrequency.centerXAnchor.constraint(equalTo: centerXAnchor),
            stationFrequency.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: Constants.sideForHeader),
            
            stationTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            stationTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            stationTitle.topAnchor.constraint(equalTo: stationFrequency.bottomAnchor),
            
            radioFaviconImageView.topAnchor.constraint(equalTo: stationTitle.bottomAnchor, constant: 10),
            radioFaviconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            radioFaviconImageView.widthAnchor.constraint(equalToConstant: 65),
            radioFaviconImageView.heightAnchor.constraint(equalToConstant: 65),
            
            playerControler.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerControler.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 255/335),
            playerControler.heightAnchor.constraint(equalTo: playerControler.widthAnchor, multiplier: 127/255),
            playerControler.bottomAnchor.constraint(equalTo: volumeControler.topAnchor, constant: -30),
            
            volumeControler.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            volumeControler.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 38),
            volumeControler.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -38),
            volumeControler.heightAnchor.constraint(equalToConstant: 16),
            
            waveAnimationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            waveAnimationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            waveAnimationView.widthAnchor.constraint(equalToConstant: 400),
            waveAnimationView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    // MARK: - Actions
    @objc private func profileTap() {
        delegate?.profileButtonTapped()
    }
    
    @objc private func arrowButtonTap() {
        delegate?.arrowButtonTapped()
    }
    
    @objc private func favoriteButtonTapped() {
        delegate?.addFavoriteButtonTapped()
    }
}


