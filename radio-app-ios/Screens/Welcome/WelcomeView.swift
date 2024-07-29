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
    
    private let largeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = NSLocalizedString("Let’s Get\nStarted", comment: "")
        label.font = UIFont.boldSystemFont(ofSize: 54)
        return label
    }()
    
    private let smallLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.text = NSLocalizedString("Enjoy the best radio stations\nfrom your home, don't miss\nout on anything", comment: "")
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Get Started", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 41/255, blue: 109/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
            largeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            largeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            
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
