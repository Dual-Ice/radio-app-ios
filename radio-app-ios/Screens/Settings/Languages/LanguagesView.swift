//
//  LanguagesView.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 04.08.2024.
//

import UIKit

final class LanguagesView: UIView {

    // MARK: UI Elements

    private let backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = Image.signInBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let userInfoView = UserInfoView()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LanguagesView {

    func setView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        [backgroundView, userInfoView].forEach { self.addSubview($0) }
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            userInfoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            userInfoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            userInfoView.heightAnchor.constraint(equalToConstant: 100),
            userInfoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100)

        ])
    }
}
