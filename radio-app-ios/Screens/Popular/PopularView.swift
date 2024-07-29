//
//  PopularView.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 29.07.2024.
//

import UIKit

protocol PopularViewDelegate: AnyObject {
    func tappedButton()
}


final class PopularView: UIView {
    
    weak var delegate: PopularViewDelegate?
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("ButtonValue", comment: ""), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

//    private let label = UILabel.makeCustomLabel(
//        key: "LabelValue",
//        font:UIFont.DisplayFont.displayMedium(size: 20),
//        textColor: .systemBlue,
//        numberOfLines: nil,
//        textAligment: .center)

    private let label = UILabel.makeSignInTitleLabel(text: "Hello world")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
        self.backgroundColor = UIColor.customDeepBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegates(_ value: PopularController) {
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
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
        ])
    }
    
    @objc private func buttonTapped(){
        delegate?.tappedButton()
    }
    
}
