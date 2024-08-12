//
//  BrowseCell.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 10.08.2024.
//

import UIKit

class CustomCell: UICollectionViewCell {

    static let identifier = "CustomCell"

    private let titleLabel = UILabel.makeCustomLabelBold(key: nil, fontSize: 28, textColor: .white, numberOfLines: 2, textAligment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = Color.customGray.cgColor
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
        
        [titleLabel].forEach { addSubview($0) }
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
            
    func configure(with key: String) {
        titleLabel.text = NSLocalizedString(key, comment: "")
    }
}


