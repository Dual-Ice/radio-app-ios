//
//  PasswordView.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 31.07.2024.
//

import UIKit


protocol PasswordViewDelegate: AnyObject {
    func tappedButton()
}

final class PasswordView: UIView {
    weak var delegate: PasswordViewDelegate?

    private var triangleImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "trianglePink")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private let headingLabel = UILabel.makeCustomLabelBold(
        key: "ForgotHeadingValue",
        fontSize: Constants.headingSize,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .center)
    
    private let emailLabel = UILabel.makeCustomLabel(
        key: "EmailLabel",
        fontSize: Constants.regularLabelSize,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .left)
        
    private let emailTexfield = UITextField.makeCustomPinkTextfield(placeholderText: "YourEmailValue")
    
    private let button = UIButton.makeRectangularButtonWithTitle(title: "SentButtonValue")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegates(_ value: PasswordController) {
        delegate = value
    }
    
    private func setViews() {
        self.backgroundColor = Color.backgroundBlue
        headingLabel.textAlignment = .left
    
        [
            headingLabel,
            triangleImage,
            emailLabel,
            emailTexfield,
            button
        ].forEach { addSubview($0) }
        
        setUpViews()
    }
    
    private func setUpViews(){
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([

            triangleImage.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topOffset * 8),
            triangleImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            headingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topOffset * 22),
            headingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            emailLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: Constants.topOffset * 4),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            
            emailTexfield.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Constants.topOffset),
            emailTexfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            emailTexfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.customOffset),
            emailTexfield.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            
            button.topAnchor.constraint(equalTo: emailTexfield.bottomAnchor, constant: Constants.topOffset * 8),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.customOffset),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.customOffset),
            button.heightAnchor.constraint(equalToConstant: Constants.bigButtonHeight)
        ])
    }
    
    @objc private func buttonTapped(){
        delegate?.tappedButton()
    }
    
}


