//
//  HeaderView.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 10.08.2024.
//

import UIKit

final class LanguageTableHeaderView: UIView {

    // MARK: UI Elements

    private let titleLabel = UILabel.makeCustomLabel(
        key: "AvailableLanguages",
        fontSize: 14,
        textColor: .systemGray,
        numberOfLines: 1,
        textAligment: .left)

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: Layout

private extension LanguageTableHeaderView {

    func setupView() {
        backgroundColor = .clear
        self.addSubview(titleLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
