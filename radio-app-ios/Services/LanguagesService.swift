//
//  LanguagesService.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 12.08.2024.
//

import Foundation
final class LanguagesService {
    func getAvailableLanguages() -> [String:String] {
        
        var languagesWithNames: [String:String] = [:]
        Languages.allCases.forEach { language in
            languagesWithNames[language.code] = language.label
        }
        
        return languagesWithNames
    }
    
    func getCurrentLanguageCode() -> String {
        if let savedLanguages = UserDefaults.standard.array(forKey: "AppleLanguages") as? [String],
           let firstLanguage = savedLanguages.first {
            let fullCode = getFullLanguageCode(from: firstLanguage)
            return fullCode
        }
        
        let preferredLanguage = Locale.preferredLanguages.first ?? "en"
        return getFullLanguageCode(from: preferredLanguage)
    }

    private func getFullLanguageCode(from code: String) -> String {
        switch code {
        case "en":
            return "en-US"
        case "ru":
            return "ru-RU"
        default:
            return code // Вернуть полный код без изменений, если он уже в полном формате
        }
    }
    
    func setLanguage(code: String) -> Bool {
        
        if (code == "" || code == getCurrentLanguageCode()) {
            return false
        }
        
        UserDefaults.standard.set([code], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        return true
    }
}

enum Languages: CaseIterable {
    case en, ru
}

extension Languages {
    var label: String {
        switch self {
        case .en:
            return "English"
        case .ru:
            return "Русский"
        }
    }
    
    var code: String {
        switch self {
        case .en:
            return "en-US"
        case .ru:
            return "ru-RU"
        }
    }
}
