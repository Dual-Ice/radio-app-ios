//
//  LanguagePresenter.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 08.08.2024.
//

import UIKit

protocol LanguagePresenterProtocol {
    init(view: LanguageVCProtocol)
    var languages: [String] { get }
    var lastSelectedIndexPath: IndexPath? { get set }
}

final class LanguagePresenter: LanguagePresenterProtocol {

    private weak var view: LanguageVCProtocol?

    var languages = ["English", "Русский"]
    var lastSelectedIndexPath: IndexPath?

    init(view: LanguageVCProtocol) {
        self.view = view
        self.lastSelectedIndexPath = IndexPath(row: 0, section: 0)
    }
}
