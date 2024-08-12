//
//  ProfileView.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 07.08.2024.
//

import UIKit

final class AboutView: UIView {

    // MARK: UI Elements

    private let backgroundView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        view.image = Image.signInBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let text = UILabel.makeCustomLabel(
        key: "AboutText",
        fontSize: 16,
        textColor: .white,
        numberOfLines: 0,
        textAligment: .left,
        wrapText: true
    )

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

private extension AboutView {

    func setView() {
        self.addSubview(backgroundView)
        backgroundView.addSubview(stackView)
        stackView.addArrangedSubview(text)
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupContraints() {

        NSLayoutConstraint.activate([

            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: LayoutConstants.sideOffset),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -LayoutConstants.sideOffset),
            stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 100),
        ])

    }
    
    enum LayoutConstants {
        static let sideOffset: CGFloat = 16
    }
}
