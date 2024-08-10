//
//  UserInfoView.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 04.08.2024.
//

import UIKit

    // MARK: UserInfoView Delegate

protocol UserInfoViewDelegate: AnyObject {
    func editButtonTapped()
//    func setData(with user: User)
}

    // MARK: UserInfoView

final class UserInfoView: UIView {

    // MARK: Properties

    weak var delegate: UserInfoViewDelegate?

    // MARK: UI Elements

    private let userImage: UIImageView = {
        let image = UIImageView()
        image.image = Image.userMock
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let userName = UILabel.makeCustomLabel(
        key: "HeaderUserName",
        fontSize: 18,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left)

    private let userEmail = UILabel.makeCustomLabel(
        key: "HeaderUserEmail",
        fontSize: 16,
        textColor: .systemGray,
        numberOfLines: 1,
        textAligment: .left)

    private let editButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.editSquare, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setMainView()
        setupConstraints()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Override Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }

    // MARK: Public Methods

    // тут будем сетить данные юзера
    // func setData(with data: Data) {}

    // MARK: Private Methods

    private func setupTargets() {
        editButton.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
    }

    // MARK: Selector Methods

    @objc private func editButtonAction() {
        delegate?.editButtonTapped()
    }
}

private extension UserInfoView {

    func setViews() {
        [userImage, userName, userEmail, editButton].forEach { self.addSubview($0) }
    }

    #warning("убрать в расширение + переименовать в styleMainView")
    func setMainView() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = 1
        self.layer.borderColor = Color.borderColor.cgColor
        self.layer.cornerRadius = 15
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            userImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstants.bigSideOffset),
            userImage.widthAnchor.constraint(equalToConstant: LayoutConstants.userImageSize),
            userImage.heightAnchor.constraint(equalToConstant: LayoutConstants.userImageSize),

            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: LayoutConstants.smallSideOffset),
            userName.bottomAnchor.constraint(equalTo: userImage.centerYAnchor, constant: -LayoutConstants.labelOffset),

            userEmail.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: LayoutConstants.smallSideOffset),
            userEmail.topAnchor.constraint(equalTo: userImage.centerYAnchor, constant: LayoutConstants.labelOffset),

            editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.bigSideOffset),
            editButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            editButton.widthAnchor.constraint(equalToConstant: LayoutConstants.editButtonSize),
            editButton.heightAnchor.constraint(equalToConstant: LayoutConstants.editButtonSize)
        ])
    }

    enum LayoutConstants {

        static let userImageSize: CGFloat = 54
        static let editButtonSize: CGFloat = 32

        static let bigSideOffset: CGFloat = 16
        static let smallSideOffset: CGFloat = 12

        static let labelOffset: CGFloat = 4
    }
}
