//
//  DetailView.swift
//  radio-app-ios
//
//  Created by Maksim on 30.07.2024.
//

import UIKit

protocol DetailViewDelegate: AnyObject {
    func addFavoriteButtonTapped()
    func volumeSliderChanged(_ sender: UISlider)
    func playButtonTapped()
    func playNextButtonTapped()
    func playBackButtonTapped()
    func arrowButtonTapped()
    func profileButtonTapped()
}

final class DetailView: UIView {
    
    weak var delegate: DetailViewDelegate?
    
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
    
    private lazy var profileImageView = RoundedTriangleImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), radius: 10)

    private let headerLabel = UILabel.makeCustomLabel(
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
        element.image = UIImage(systemName: "waveform")
        element.tintColor = .white
        element.layer.cornerRadius = 35
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    
    private lazy var equalizerImageView: UIImageView = {
        let element = UIImageView()
        element.image = Image.equalizer
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
    
    private lazy var controlStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fillProportionally
        element.alignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var playBackButton: UIButton = {
        let element = UIButton()
        element.setImage(Image.playerBack, for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var playButton: UIButton = {
        let element = UIButton()
        element.setImage(Image.playerMain, for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var playNextButton: UIButton = {
        let element = UIButton()
        element.setImage(Image.playerNext, for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var volumeStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 10
        element.alignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var volumeIcon: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "speaker.wave.3")
        element.tintColor = .lightGray
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var slider: UISlider = {
        let element = UISlider()
        element.minimumValue = 0
        element.maximumValue = 100
        element.value = 65
        element.tintColor = Color.customLightBlue
        element.translatesAutoresizingMaskIntoConstraints = false
        element.thumbTintColor = Color.customLightBlue
        element.setThumbImage(Image.pointBlue, for: .normal)
        element.setThumbImage(Image.pointBlue, for: .highlighted)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var percentsLabel: UILabel = {
        let element = UILabel()
        element.text = "\(Int(slider.value))%"
        element.font = .systemFont(ofSize: 15)
        element.textColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegates(_ value: DetailController) {
        delegate = value
    }
    
    func configureUI(with stationData: Station) {
        if let imagePath = stationData.favicon, let imageUrl = URL(string: imagePath) {
            radioFaviconImageView.getImage(from: imageUrl)
        }
        stationTitle.text = stationData.name
        stationFrequency.text = "Streaming" // no data from API
    }
    
    func setUserAvatar(_ image: UIImage?) {
        if let userAvatar = image{
            profileImageView.setImage(userAvatar)
        }
    }
    
    // MARK: - Private Methods
    private func setViews() {
        [
            backgroundImageView,
            headerStackView,
            equalizerImageView,
            addFavoriteButton,
            radioFaviconImageView,
            stationFrequency,
            stationTitle,
            controlStackView,
            volumeStackView
        ].forEach { addSubview($0) }
        
        headerStackView.addArrangedSubview(arrowButton)
        headerStackView.addArrangedSubview(headerLabel)
        headerStackView.addArrangedSubview(profileImageView)
        
        controlStackView.addArrangedSubview(playBackButton)
        controlStackView.addArrangedSubview(playButton)
        controlStackView.addArrangedSubview(playNextButton)
        
        volumeStackView.addArrangedSubview(volumeIcon)
        volumeStackView.addArrangedSubview(slider)
        volumeStackView.addArrangedSubview(percentsLabel)
        
        setUpViews()
    }
    
    private func setUpViews(){
        addFavoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        playButton.addTarget(self, action: #selector(playButtonTap), for: .touchUpInside)
        playNextButton.addTarget(self, action: #selector(playNextButtonTap), for: .touchUpInside)
        playBackButton.addTarget(self, action: #selector(playBackButtonTap), for: .touchUpInside)
        arrowButton.addTarget(self, action: #selector(arrowButtonTap), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileTap))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            headerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.sideForHeader),
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sideForHeader),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideForHeader),
            
            arrowButton.widthAnchor.constraint(equalToConstant: Constants.profileImageSize),
            arrowButton.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),

            profileImageView.widthAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),
            
            addFavoriteButton.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: Constants.sideForFavorite),
            addFavoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideForFavoriteTrailing),
            addFavoriteButton.widthAnchor.constraint(equalToConstant: 20),
            addFavoriteButton.heightAnchor.constraint(equalToConstant: 20),
            
            radioFaviconImageView.topAnchor.constraint(equalTo: stationFrequency.topAnchor, constant: 10),
            radioFaviconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            radioFaviconImageView.widthAnchor.constraint(equalToConstant: 65),
            radioFaviconImageView.heightAnchor.constraint(equalToConstant: 65),
            
            equalizerImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            equalizerImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            stationFrequency.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stationFrequency.topAnchor.constraint(equalTo: addFavoriteButton.bottomAnchor, constant: Constants.sideForHeader),
            
            stationTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stationTitle.topAnchor.constraint(equalTo: stationFrequency.bottomAnchor),
            
            controlStackView.topAnchor.constraint(equalTo: self.equalizerImageView.bottomAnchor),
            controlStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sideForStackView),
            controlStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideForStackView),
            
            volumeStackView.topAnchor.constraint(equalTo: self.controlStackView.bottomAnchor, constant: Constants.sideForHeader),
            volumeStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sideForStackView),
            volumeStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideForStackView),
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
    
    @objc private func playButtonTap() {
        delegate?.playButtonTapped()
    }
    
    @objc private func playNextButtonTap() {
        delegate?.playNextButtonTapped()
    }
    
    @objc private func playBackButtonTap() {
        delegate?.playBackButtonTapped()
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        delegate?.volumeSliderChanged(sender)
    }
}


