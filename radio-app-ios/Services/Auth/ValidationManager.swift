//
//  ValidationManager.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 03.08.2024.
//

import Foundation

final class ValidationManager {
    
    static func isValidDisplayName(_ displayName: String) -> Bool {
        let displayName = displayName.trimmingCharacters(in: .whitespacesAndNewlines)
        let displayNameRegEx = "\\w{3,24}"
        let displayNamePredicate = NSPredicate(format:"SELF MATCHES %@", displayNameRegEx)
        return displayNamePredicate.evaluate(with: displayName)
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRegEx = "^[a-zA-Z0-9]{6,32}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPredicate.evaluate(with: password)
    }
}
