//
//  CustomTabBarButton.swift
//  radio-app-ios
//
//  Created by nik on 31.07.24.
//

import UIKit

final class CustomTabBarButton: UIButton {
    private let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.customLightBlue
        view.layer.cornerRadius = 15.0 / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var buttonIdentifier: String
    
    init(lableText: String, identifier: String) {
        buttonIdentifier = identifier
        super.init(frame: .zero)
        setupButton(labelText: lableText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(labelText: String) {
        buttonLabel.text = labelText
        circleView.alpha = 0.0
        
        addSubview(circleView)
        addSubview(buttonLabel)
        
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: 15),
            circleView.heightAnchor.constraint(equalToConstant: 15),
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            buttonLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 15),
            buttonLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            buttonLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setActive(_ isActive: Bool) {
        circleView.alpha = isActive ? 1.0 : 0.0
        buttonLabel.alpha = isActive ? 1.0 : 0.3
        self.isEnabled = !isActive
    }
}
