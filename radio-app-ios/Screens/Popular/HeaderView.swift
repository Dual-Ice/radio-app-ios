//
//  HeaderView.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 05.08.2024.
//

import UIKit


protocol HeaderViewDelegate: AnyObject {
    func profileTapped()
}

final class HeaderView: UIView {
    
    weak var delegate: HeaderViewDelegate?
    
    private let greetingLabel = UILabel.makeCustomLabelBold(key: "Hello", fontSize: 26, textColor: .white, numberOfLines: 1, textAligment: .left)
    private let usernameLabel = UILabel.makeCustomLabelBold(key: "Mark", fontSize: 26, textColor: Color.customPink, numberOfLines: 1, textAligment: .left)
    private let profileImageView = RoundedTriangleImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), radius: 10)
    private let titleLabel = UILabel.makeCustomLabel(key: nil, fontSize: 30, textColor: .white, numberOfLines: 1, textAligment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        layoutViews()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        [greetingLabel, usernameLabel, profileImageView, titleLabel].forEach { addSubview($0) }
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            greetingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            greetingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            usernameLabel.leadingAnchor.constraint(equalTo: greetingLabel.trailingAnchor, constant: 5),
            usernameLabel.centerYAnchor.constraint(equalTo: greetingLabel.centerYAnchor),
            
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            profileImageView.centerYAnchor.constraint(equalTo: greetingLabel.centerYAnchor),
//            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupActions() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
    }
    
    @objc private func profileTapped() {
        delegate?.profileTapped()
    }
    
    func configure(with username: String, profileImage: UIImage, title: String) {
        usernameLabel.text = username
        profileImageView.setImage(profileImage)
        titleLabel.text = title
    }
    
    func setDelegate(value: HeaderViewDelegate) {
        delegate = value
    }
}
