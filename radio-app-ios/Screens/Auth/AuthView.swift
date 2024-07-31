//
//  AuthView.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 30.07.2024.
//

import UIKit


protocol AuthViewDelegate: AnyObject {
    func tappedButton()
}


final class AuthView: UIView {
    weak var delegate: AuthViewDelegate?
    
    private let button = UIButton.makeCustomButtonWithArrow()

    private let label = UILabel.makeCustomLabel(
        key: "LabelValue",
        fontSize: 40,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
        self.backgroundColor = Color.customDeepBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegates(_ value: AuthController) {
        delegate = value
    }
    
    private func setViews() {
        self.backgroundColor = .white
        [
            label,
            button,
            
        ].forEach { addSubview($0) }
        
        setUpViews()
    }
    
    private func setUpViews(){
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Constants.sideOffset),
            button.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    @objc private func buttonTapped(){
        delegate?.tappedButton()
    }
    
}

