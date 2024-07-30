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

    /// пример кнопки с тайтлом
//    private let button = UIButton.makeCustomButtonWithLabel(
//        color: .pink,
//        title: "Tap")

    /// пример кнопки со стрелочкой
    private let button = UIButton.makeCustomButtonWithArrow()

    /// пример обычного лейбла
    private let label = UILabel.makeCustomLabel(
        key: "LabelValue",
        fontSize: 40,
        textColor: .white,
        numberOfLines: nil,
        textAligment: .center)

    /// пример лейбла с толстым шрифтом
//    private let label = UILabel.makeCustomLabelBold(
//        key: "LabelValue",
//        fontSize: 40,
//        textColor: .white,
//        numberOfLines: nil,
//        textAligment: .center)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
        self.backgroundColor = Color.customDeepBlue
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
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func buttonTapped(){
        delegate?.tappedButton()
    }
    
}
