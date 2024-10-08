//
//  Profile.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

    // MARK: LanguageVC Protocol

protocol LanguageVCProtocol: AnyObject {
}

    // MARK: LanguageVC

final class LanguageVC: UIViewController {

    var presenter: LanguagePresenterProtocol!

    // MARK: UI Elements

    private let languageView = LanguageView()

    // MARK: Life cycle

    override func loadView() {
        view = languageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: Private Methods

    private func setupTableView() {
        languageView.setTableViewDelegate(delegate: self, dataSource: self)
    }
}

    // MARK: Work with table

extension LanguageVC: UITableViewDelegate, UITableViewDataSource {

    /// header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = LanguageTableHeaderView()
        return headerView
    }

    /// cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getLanguages().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: LanguageCell.reuseID,
                for: indexPath) as? LanguageCell
        else { return UITableViewCell() }

        let languages = presenter.getLanguages()
        let languageCode = Array(languages.keys)[indexPath.row]
        let languageName = languages[languageCode] ?? ""
        let checkValue = (languageCode == presenter.getCurrentLanguageCode())
        cell.configure(with: languageName)
        cell.setCheckmarkValue(checkValue)
        return cell
    }

    /// cell tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: false)
        let languages = presenter.getLanguages()
        let languageCode = Array(languages.keys)[indexPath.row]
        presenter.setLanguage(code: languageCode)
        
        tableView.reloadData()
    }
}

// MARK: LanguageVCProtocol

extension LanguageVC: LanguageVCProtocol {
}
