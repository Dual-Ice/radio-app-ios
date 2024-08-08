//
//  ProfileView.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 07.08.2024.
//

import UIKit

final class LanguageView: UIView {

    // MARK: UI Elements

    private let backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = Image.signInBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setupContraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: Layout

private extension LanguageView {

    func setView() {
        self.addSubview(backgroundView)
    }

    func setupContraints() {

        NSLayoutConstraint.activate([

            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

        ])

    }

    enum LayoutConstants {

    }
}
