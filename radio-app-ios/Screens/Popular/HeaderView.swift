//
//  HeaderView.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 05.08.2024.
//

import UIKit

final class HeaderView: UIView {
    private let playPinkImage: UIImageView = {
        let imageView = UIImageView(image: Image.playPink)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let greetingLabel = UILabel.makeCustomLabelBold(key: "Hello", fontSize: 26, textColor: .white, numberOfLines: 1, textAligment: .left)
    private let usernameLabel = UILabel.makeCustomLabelBold(key: "Mark", fontSize: 26, textColor: Color.customPink, numberOfLines: 1, textAligment: .left)
    
    //MARK: Заменить на картинку профиля
    private let profileButton = UIButton.makeCustomButtonWithImage(image: Image.heartSelected)
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
        profileButton.layer.masksToBounds = true
        
        [playPinkImage, greetingLabel, usernameLabel, profileButton, titleLabel].forEach { addSubview($0) }
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
            
            profileButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            profileButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileButton.widthAnchor.constraint(equalToConstant: 30),
            profileButton.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            titleLabel.topAnchor.constraint(equalTo: playPinkImage.bottomAnchor, constant: 25)
        ])
    }
    
    private func setupActions() {
        profileButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
    }
    
    @objc private func profileTapped() {
        onProfileTapped?()
    }
    
// MARK: Заполнить данные
    func loadProfileData() {
        let username = "Mark"
        let profileImage = Image.heartSelected
        
        // configure(with: username, profileImage: profileImage)
    }
    
    func configure(with username: String, profileImage: UIImage) {
        usernameLabel.text = username
        profileButton.setImage(profileImage, for: .normal)
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
