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
        let preferredLanguage = Locale.preferredLanguages.first ?? "en"
            // Преобразуем короткий код в полный код
            switch preferredLanguage {
            case "en":
                return "en-US"
            case "ru":
                return "ru-RU"
            default:
                return "en-US" // Код по умолчанию
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
