//
//  Policy.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

protocol PolicyVCProtocol: AnyObject {
}

final class PolicyVC: UIViewController, PolicyVCProtocol {

    var presenter: PolicyPresenterProtocol!

    // MARK: UI Elements

    private let backgroundView: UIImageView = {
        let view = UIImageView()
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

    private let firstTitleLabel = UILabel.makeCustomLabelBold(
        key: "Terms",
        fontSize: 14,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left)

    private let secondTitleLabel = UILabel.makeCustomLabelBold(
        key: "Changes to the Service and/or Terms",
        fontSize: 14,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left)

    private let firstTextLabel = UILabel.makeCustomLabelBold(
        key: "Introduction",
        fontSize: 14,
        textColor: .systemGray,
        numberOfLines: 0,
        textAligment: .left)

    private let secondTextLabel = UILabel.makeCustomLabelBold(
        key: "MainRules",
        fontSize: 14,
        textColor: .systemGray,
        numberOfLines: 0,
        textAligment: .left)


    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setupConstraints()
    }
}


private extension PolicyVC {

    func setView() {

        view.addSubview(backgroundView)
        backgroundView.addSubview(stackView)

        [firstTitleLabel,
         firstTextLabel,
         secondTitleLabel,
         secondTextLabel].forEach { stackView.addArrangedSubview($0) }
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: LayoutConstants.sideOffset),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -LayoutConstants.sideOffset),
            stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 100),

        ])
    }

    enum LayoutConstants {
        static let sideOffset: CGFloat = 16
    }
}
