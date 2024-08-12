//
//  SettingsHeaderView.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 11.08.2024.
//

import UIKit

#warning ("dead code")

protocol SettingsHeaderViewDelegate: AnyObject {
    func profileTapped()
}

final class SettingsHeaderView: UIView {

    weak var delegate: HeaderViewDelegate?

    // MARK: UI Elements

    private let titleLabel = UILabel.makeCustomLabelBold(
        key: "Settings",
        fontSize: 26,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left)

    private let profileImageView = RoundedTriangleImageView(
        frame: CGRect(x: 0,
                      y: 0,
                      width: 50,
                      height: 50),
        radius: 10)


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, profileImage: UIImage) {
        titleLabel.text = title
        profileImageView.setImage(profileImage)
    }

    func setDelegate(value: HeaderViewDelegate) {
        delegate = value
    }

}

private extension SettingsHeaderView {

    func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        [titleLabel, profileImageView].forEach { addSubview($0) }
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutConstants.sideOffset),
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: LayoutConstants.profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: LayoutConstants.profileImageSize),


        ])

        enum LayoutConstants {
            static let profileImageSize: CGFloat = 50
            static let sideOffset: CGFloat = 20
        }
    }
}
