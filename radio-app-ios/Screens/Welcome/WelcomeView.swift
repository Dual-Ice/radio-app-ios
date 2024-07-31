//
//  OnboardingView.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 29.07.2024.
//

import UIKit

protocol WelcomeViewDelegate: AnyObject {
    func tappedButton()
}

final class WelcomeView: UIView {
    
    weak var delegate: WelcomeViewDelegate?
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "onboardingBackground")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let largeLabel = UILabel.makeCustomLabelBold(key: "WelcomeTitleLabel", fontSize: 54, textColor: .white, numberOfLines: 0, textAligment: .left)
    
    private let smallLabel = UILabel.makeCustomLabel(key: "WelcomeLabel", fontSize: 16, textColor: .white, numberOfLines: 0, textAligment: .left)
    
    private let button = UIButton.makeCustomButtonWithLabel(color: .pink, key: "ButtonGetStarted")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegates(_ value: WelcomeController) {
        delegate = value
    }
    
    private func setViews() {
        self.backgroundColor = .white
        
        [
            imageView,
            largeLabel,
            smallLabel,
            button,
            
        ].forEach { addSubview($0) }
        
        setUpViews()
    }
    
    private func setUpViews(){
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            largeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            largeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            smallLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            smallLabel.topAnchor.constraint(equalTo: largeLabel.bottomAnchor, constant: 15),
            
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            button.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            button.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    @objc private func buttonTapped(){
        delegate?.tappedButton()
    }
}
