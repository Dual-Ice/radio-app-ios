//
//  SettingView.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 05.08.2024.
//

import UIKit

final class SettingView: UIView {

    // MARK: UI Elements

    private var viewIcon = UIView()
    private var viewLabel = UILabel()

    private let arrowIcon: UIView = {
        let arrowView = UIImageView(image: Image.arrowBlue)
        arrowView.backgroundColor = Color.blueArrowBackground
        arrowView.layer.cornerRadius = LayoutConstants.iconSize / 2
        return arrowView
    }()

    
    // MARK: Init
    init(title: String) {
        super.init(frame: .zero)
        configureView(with: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func configureViewIcon(with title: String) -> UIView {
        let view = UIView()
        view.backgroundColor = Color.iconDarkBackground
        view.layer.cornerRadius = LayoutConstants.iconSize / 2

        if !title.isEmpty {
            let imageView = UIImageView(image: UIImage(named: title))
            view.addSubview(imageView)

        #warning("поправить значки")
        }

        return view
    }

    // MARK: Public Methods
    func configureView(with title: String) {
        viewIcon = configureViewIcon(with: title)
        #warning("вот тут как будто бы нужен шрифт medium")
        viewLabel = UILabel.makeCustomLabelBold(
            key: title,
            fontSize: 16,
            textColor: .white,
            numberOfLines: 1,
            textAligment: .left)

        setView()
        setupConstraints()
    }
}

private extension SettingView {

    func setView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        viewIcon.translatesAutoresizingMaskIntoConstraints = false
        arrowIcon.translatesAutoresizingMaskIntoConstraints = false

        [viewIcon, viewLabel, arrowIcon].forEach { self.addSubview($0) }
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            viewIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            viewIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewIcon.widthAnchor.constraint(equalToConstant: LayoutConstants.iconSize),
            viewIcon.heightAnchor.constraint(equalToConstant: LayoutConstants.iconSize),

            viewLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            viewLabel.leadingAnchor.constraint(equalTo: viewIcon.trailingAnchor, constant: LayoutConstants.sideOffset),

            arrowIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            arrowIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            arrowIcon.widthAnchor.constraint(equalToConstant: LayoutConstants.iconSize),
            arrowIcon.heightAnchor.constraint(equalToConstant: LayoutConstants.iconSize)
        ])
    }

    enum LayoutConstants {
        static let sideOffset: CGFloat = 12
        static let iconSize: CGFloat = 28
    }
}
