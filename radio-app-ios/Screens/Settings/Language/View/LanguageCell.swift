//
//  LanguageCell.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 08.08.2024.
//

import UIKit

final class LanguageCell: UITableViewCell {

    // MARK: Properties

    static let reuseID = String(describing: LanguageCell.self)

    private var isChecked = false {
        didSet {
            checkmarkImageView.isHidden = !isChecked
        }
    }

    // MARK: UI Elements

    private var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Language"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = false
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

//    private var lineView: UIView = {
//        var view = UIView()
//        view.backgroundColor = .systemGray
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()

    private let checkmarkImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = Color.customLightBlue
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods

    func configure(with text: String) {
        mainLabel.text = text
    }

    func setCheckmarkValue(_ value: Bool) {
        isChecked = value
    }
}

private extension LanguageCell {

    func setView() {
        selectionStyle = .none
        backgroundColor = .clear
        [mainLabel, /*lineView,*/ checkmarkImageView].forEach { addSubview($0) }
    }

    func setConstraints() {
        
        NSLayoutConstraint.activate([

            mainLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstants.sideOffset),

            checkmarkImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkmarkImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.sideOffset),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: LayoutConstants.checkMarkSize),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: LayoutConstants.checkMarkSize),

//            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstants.bigSideOffset),
//            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.bigSideOffset),
//            lineView.heightAnchor.constraint(equalToConstant: 1)

        ])
    }

    enum LayoutConstants {
        static let bigSideOffset: CGFloat = 24
        static let sideOffset: CGFloat = 16

        static let checkMarkSize: CGFloat = 20
    }
}
