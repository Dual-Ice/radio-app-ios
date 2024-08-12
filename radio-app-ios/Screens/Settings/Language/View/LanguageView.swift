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
        view.backgroundColor = .black
        view.image = Image.signInBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseID)
        table.backgroundColor = .clear
        table.layer.cornerRadius = 15
        table.layer.borderWidth = 1
        table.layer.borderColor = Color.borderColor.cgColor
        table.isUserInteractionEnabled = true
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
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

    // MARK: Public Methods

    func setTableViewDelegate(delegate: UITableViewDelegate,
                              dataSource: UITableViewDataSource) 
    {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}

    // MARK: Layout

private extension LanguageView {

    func setView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backgroundView)
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addSubview(tableView)
    }

    func setupContraints() {

        NSLayoutConstraint.activate([

            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstants.sideOffset),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.sideOffset),
            tableView.heightAnchor.constraint(equalToConstant: 140)

        ])
    }

    enum LayoutConstants {
        static let bigVerticalOffset: CGFloat = 36
        static let verticalOffset: CGFloat = 24
        static let sideOffset: CGFloat = 16
    }
}
