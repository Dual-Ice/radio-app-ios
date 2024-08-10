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
    }
}

// MARK: LanguageVCProtocol

extension LanguageVC: LanguageVCProtocol {
}

