//
//  About.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

    // MARK: AboutVC Protocol

protocol AboutVCProtocol: AnyObject {

}

    // MARK: AboutVC

final class AboutVC: UIViewController, AboutVCProtocol {

    var presenter: AboutPresenterProtocol!

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

    private let firstTextLabel = UILabel.makeCustomLabel(
        key: "AboutText",
        fontSize: 16,
        textColor: .white,
        numberOfLines: 0,
        textAligment: .left,
        wrapText: true
    )


    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setupConstraints()
    }
    
    func setView() {

        view.addSubview(backgroundView)
        backgroundView.addSubview(stackView)

        [
         firstTextLabel].forEach { stackView.addArrangedSubview($0) }
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
