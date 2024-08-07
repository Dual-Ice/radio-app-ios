//
//  HeaderView.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 05.08.2024.
//

import UIKit

final class HeaderView: UIView {
    private let playPinkImage = UIImageView.makeSimpleImage(imageName: "playPink")
    private let greetingLabel = UILabel.makeCustomLabelBold(key: "Hello", fontSize: 26, textColor: .white, numberOfLines: 1, textAligment: .left)
    private let usernameLabel = UILabel.makeCustomLabelBold(key: "Mark", fontSize: 26, textColor: Color.customPink, numberOfLines: 1, textAligment: .left)
    
    //MARK: Заменить на картинку профиля
    private let profileImageView = RoundedTriangleImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70), radius: 15)
//    private let profileButton = UIButton.makeCustomButtonWithImage(image: Image.heartSelected)
    private let titleLabel = UILabel.makeCustomLabel(key: "Popular", fontSize: 30, textColor: .white, numberOfLines: 1, textAligment: .left)
    
    var onProfileTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        layoutViews()
        setupActions()
        loadProfileData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        profileImageView.layer.masksToBounds = true
        if let image = UIImage(named: "onboardingBackground") {
            profileImageView.setImage(image)
        }
        
        [playPinkImage, greetingLabel, usernameLabel, profileImageView, titleLabel].forEach { addSubview($0) }
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            playPinkImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            playPinkImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            playPinkImage.widthAnchor.constraint(equalToConstant: 30),
            playPinkImage.heightAnchor.constraint(equalToConstant: 30),
            
            greetingLabel.leadingAnchor.constraint(equalTo: playPinkImage.trailingAnchor, constant: 10),
            greetingLabel.centerYAnchor.constraint(equalTo: playPinkImage.centerYAnchor),
            
            usernameLabel.leadingAnchor.constraint(equalTo: greetingLabel.trailingAnchor, constant: 5),
            usernameLabel.centerYAnchor.constraint(equalTo: greetingLabel.centerYAnchor),
            
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 30),
            profileImageView.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            titleLabel.topAnchor.constraint(equalTo: playPinkImage.bottomAnchor, constant: 25)
        ])
    }
    
    private func setupActions() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true }
    
    @objc private func profileTapped() {
        onProfileTapped?()
    }
    
// MARK: Заполнить данные
    func loadProfileData() {
        let username = "Mark"
        let profileImage = Image.heartSelected
        
         configure(with: username, profileImage: profileImage!)
    }
    
    func configure(with username: String, profileImage: UIImage) {
        usernameLabel.text = username
        profileImageView.setImage(profileImage)
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
