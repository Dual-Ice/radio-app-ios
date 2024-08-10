//
//  ProfileView.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 07.08.2024.
//

import UIKit

    // MARK: LanguageView Delegate

protocol LanguageViewDelegate: AnyObject {
}

// MARK: LanguageView

final class LanguageView: UIView {

    // MARK: UI Elements

    private let backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = Image.signInBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = Color.borderColor.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel = UILabel.makeCustomLabel(
        key: "AvailableLanguages",
        fontSize: 14,
        textColor: .systemGray,
        numberOfLines: 1,
        textAligment: .left)

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseID)
        table.backgroundColor = .clear
        table.isScrollEnabled = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setupContraints()
        setTableDelegate()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // move to VC
    func setTableDelegate() {
//        tableView.dataSource = self
//        tableView.delegate = self
    }
}

// move to VC
//extension LanguageView: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        presenter.languages.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard
//            let cell = tableView.dequ32eueReusableCell(
//                withIdentifier: LanguageCell.reuseID,
//                for: indexPath) as? LanguageCell
//        else { return UITableViewCell() }
//
//        let language = presenter.languages[indexPath.row]
//        let checkValue = (indexPath == presenter.lastSelectedIndexPath)
//        cell.configure(with: language)
//        cell.setCheckmarkValue(checkValue)
//        return cell
//    }
//}

    // MARK: Layout

private extension LanguageView {

    func setView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backgroundView)
        backgroundView.addSubview(mainView)
        [titleLabel, tableView].forEach { mainView.addSubview($0) }
    }

    func setupContraints() {

        NSLayoutConstraint.activate([

            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            mainView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 100),
            mainView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: LayoutConstants.sideOffset),
            mainView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -LayoutConstants.sideOffset),
            mainView.heightAnchor.constraint(equalToConstant: 160),

            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: LayoutConstants.verticalOffset),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: LayoutConstants.sideOffset),

            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutConstants.verticalOffset),
            tableView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: LayoutConstants.sideOffset),
            tableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -LayoutConstants.sideOffset),
            tableView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)

        ])
    }

    enum LayoutConstants {
        static let bigVerticalOffset: CGFloat = 36
        static let verticalOffset: CGFloat = 24
        static let sideOffset: CGFloat = 16
    }
}
