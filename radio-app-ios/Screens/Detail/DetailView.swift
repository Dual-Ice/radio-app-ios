//
//  DetailView.swift
//  radio-app-ios
//
//  Created by Maksim on 30.07.2024.
//

import UIKit

protocol DetailViewDelegate: AnyObject {
    func tappedButton()
}

final class DetailView: UIView {
    
    weak var delegate: DetailViewDelegate?
    
    // MARK: - UI Properties
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
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
    
    private lazy var arrowImageView: UIImageView = {
        let element = UIImageView()
        element.image = Image.arrowBack
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var profileImageView: UIImageView = {
        let element = UIImageView()
        element.image = Image.onboardingBackground
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private let headerLabel = UILabel.makeCustomLabel(
        key: "LabelPlaying",
        fontSize: 20,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .center)

    private lazy var addFavoriteButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(named: "heart"), for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var equalizerImageView: UIImageView = {
        let element = UIImageView()
        element.image = Image.equalizer
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let frequencyRadioLabel = UILabel.makeCustomLabelBold(
        key: "90.5",
        fontSize: 60,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .center)
    
    private let divelementLabel = UILabel.makeCustomLabel(
        key: "Radio Divelement",
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
        element.setThumbImage(Image.ellipse, for: .normal)
        element.setThumbImage(Image.ellipse, for: .highlighted)
        element.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var percentsLabel: UILabel = {
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyCustomShapeMask(to: profileImageView)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegates(_ value: DetailController) {
        delegate = value
    }
    
    // MARK: - Private Methods
    private func setViews() {
        self.addSubview(backgroundImageView)
        self.addSubview(headerStackView)
        self.addSubview(equalizerImageView)
        self.addSubview(addFavoriteButton)
        self.addSubview(frequencyRadioLabel)
        self.addSubview(divelementLabel)
        self.addSubview(controlStackView)
        self.addSubview(volumeStackView)
        
        headerStackView.addArrangedSubview(arrowImageView)
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
        //button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addFavoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)

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
            
            arrowImageView.widthAnchor.constraint(equalToConstant: Constants.profileImageSize),
            arrowImageView.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),

            profileImageView.widthAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),
            
            addFavoriteButton.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: Constants.sideForFavorite),
            addFavoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideForFavoriteTrailing),
            //addFavoriteButton.widthAnchor.constraint(equalToConstant: Constants.profileImageSize),
            //addFavoriteButton.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),
            
            equalizerImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            equalizerImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            frequencyRadioLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            frequencyRadioLabel.topAnchor.constraint(equalTo: addFavoriteButton.bottomAnchor, constant: Constants.sideForHeader),
            
            divelementLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            divelementLabel.topAnchor.constraint(equalTo: frequencyRadioLabel.bottomAnchor),
            
            controlStackView.topAnchor.constraint(equalTo: self.equalizerImageView.bottomAnchor, constant: Constants.sideForHeader),
            controlStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sideForStackView),
            controlStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideForStackView),
            
            volumeStackView.topAnchor.constraint(equalTo: self.controlStackView.bottomAnchor, constant: Constants.sideForHeader),
            volumeStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sideForStackView),
            volumeStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideForStackView),
        ])
    }
    // MARK: - Actions
    @objc func sliderValueChanged(_ sender: UISlider) {
        percentsLabel.text = "\(Int(sender.value))%"
        }
    
    @objc private func favoriteButtonTapped() {
        let currentImage = addFavoriteButton.image(for: .normal)
        
        if currentImage == Image.heartDeselected {
            addFavoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        } else {
            addFavoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
    
    @objc private func buttonTapped(){
        delegate?.tappedButton()
    }
    
    private func applyCustomShapeMask(to imageView: UIImageView) {
        let path = UIBezierPath()
        let width = imageView.bounds.width
        let height = imageView.bounds.height
        
        let point1 = CGPoint(x: width / 2, y: 0)
        let point2 = CGPoint(x: width, y: height)
        let point3 = CGPoint(x: 0, y: height)
        
        let controlPointOffset: CGFloat = 0
    
        path.move(to: point1)
        let controlPoint1 = CGPoint(x: point1.x + controlPointOffset, y: point1.y + controlPointOffset)
        path.addQuadCurve(to: point2, controlPoint: controlPoint1)
        
        let controlPoint2 = CGPoint(x: point2.x - controlPointOffset, y: point2.y - controlPointOffset)
        path.addQuadCurve(to: point3, controlPoint: controlPoint2)
        
        let controlPoint3 = CGPoint(x: point3.x + controlPointOffset, y: point3.y - controlPointOffset)
        path.addQuadCurve(to: point1, controlPoint: controlPoint3)
        
        path.close()

        let mask = CAShapeLayer()
        mask.path = path.cgPath
        imageView.layer.mask = mask
    }
}


