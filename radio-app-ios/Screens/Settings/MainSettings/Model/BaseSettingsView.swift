//
//  BaseSettingsView.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 05.08.2024.
//

import UIKit

    // MARK: BaseSettingsView

class BaseSettingsView: UIView {

    // MARK: Closures
    var firstViewTap: (() -> Void)?
    var secondViewTap: (() -> Void)?

    // MARK: UI Elements

    private var titelLabel = UILabel.makeCustomLabelBold(
        key: "",
        fontSize: 18,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left)

    private lazy var firstSettingView = SettingView(
        title: "")

    private lazy var secondSettingView = SettingView(
        title: "")

    private let separatorLineView: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = Color.borderColor
        return line
    }()

    // MARK: Init

    init(
        frame: CGRect,
        titleLabel: String,
        firstTitle: String,
        secondTitle: String
    ) {
        super.init(frame: frame)
        titelLabel.text = NSLocalizedString(titleLabel, comment: "")
        firstSettingView.configureView(with: firstTitle)
        secondSettingView.configureView(with: secondTitle)

        setView()
        setMainView()
        setupConstraints()
        setupTargers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setupTargers() {
        let firstTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(firstSettingTapped)
        )
        firstSettingView.addGestureRecognizer(firstTapGesture)
        firstSettingView.isUserInteractionEnabled = true

        let secondTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(secondSettingTapped)
        )
        secondSettingView.addGestureRecognizer(secondTapGesture)
        secondSettingView.isUserInteractionEnabled = true
    }

    // MARK: Selector Methods

    @objc private func firstSettingTapped() {
        firstViewTap?()
    }

    @objc private func secondSettingTapped() {
        secondViewTap?()
    }
}

private extension BaseSettingsView {

    func setMainView() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = 1
        self.layer.borderColor = Color.borderColor.cgColor
        self.layer.cornerRadius = 15
    }

    func setView() {
        [titelLabel, firstSettingView, secondSettingView, separatorLineView].forEach { self.addSubview($0) }
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            titelLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstants.smallSideOffset),
            titelLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: LayoutConstants.smallSideOffset),

            firstSettingView.topAnchor.constraint(equalTo: titelLabel.bottomAnchor, constant: LayoutConstants.bigSideOffset),
            firstSettingView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstants.smallSideOffset),
            firstSettingView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.smallSideOffset),
            firstSettingView.heightAnchor.constraint(equalToConstant: LayoutConstants.settingsHeight),

            separatorLineView.topAnchor.constraint(equalTo: firstSettingView.bottomAnchor, constant: LayoutConstants.smallSideOffset),
            separatorLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstants.separatorSideOffset),
            separatorLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.separatorSideOffset),
            separatorLineView.heightAnchor.constraint(equalToConstant: LayoutConstants.separatorHeigt),

            secondSettingView.topAnchor.constraint(equalTo: separatorLineView.bottomAnchor, constant: LayoutConstants.smallSideOffset),
            secondSettingView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstants.smallSideOffset),
            secondSettingView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.smallSideOffset),
            secondSettingView.heightAnchor.constraint(equalToConstant: LayoutConstants.settingsHeight),
        ])
    }

    enum LayoutConstants {

        static let smallSideOffset: CGFloat = 18
        static let bigSideOffset: CGFloat = 32
        static let separatorSideOffset: CGFloat = 48

        static let separatorHeigt: CGFloat = 1
        static let settingsHeight: CGFloat = 32
    }
}
