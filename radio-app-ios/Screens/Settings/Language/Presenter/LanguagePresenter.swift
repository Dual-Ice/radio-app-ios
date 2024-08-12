//
//  LanguagePresenter.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 08.08.2024.
//

import UIKit

protocol LanguagePresenterProtocol {
    init(view: LanguageVCProtocol)
    func getLanguages() -> [String:String]
    func getCurrentLanguageCode() -> String
    func setLanguage(code: String)
}

final class LanguagePresenter: LanguagePresenterProtocol {

    private weak var view: LanguageVCProtocol?
    private let languagesService = LanguagesService()
    private let alertService = AlertManager()
    private var currentLanguageCode: String
    private let availableLanguages: [String:String]

    init(view: LanguageVCProtocol) {
        self.view = view
        self.currentLanguageCode = languagesService.getCurrentLanguageCode()
        self.availableLanguages = languagesService.getAvailableLanguages()
    }
    
    func getLanguages() -> [String:String] {
        return availableLanguages
    }
    
    func setLanguage(code: String) {
        let result = languagesService.setLanguage(code: code)
        if result {
            currentLanguageCode = code
            alertService.presentAlertWithAction(
                from: view as! UIViewController,
                title: NSLocalizedString("LangAlerTitle", comment: ""),
                message: NSLocalizedString("LangChangeMessage", comment: "")
            ) {}
        }
    }
    
    func getCurrentLanguageCode() -> String {
        return currentLanguageCode
    }
}

