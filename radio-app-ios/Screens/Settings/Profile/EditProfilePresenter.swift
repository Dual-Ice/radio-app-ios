//
//  EditProfilePresenter.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 08.08.2024.
//

import UIKit

protocol EditProfilePresenterProtocol {
    init(view: EditProfileVCProtocol)
    func saveChanges(email: String, password: String)
    func changeImage()
    func didSelectImage(_ image: UIImage)
}

final class EditProfilePresenter: EditProfilePresenterProtocol {

    private weak var view: EditProfileVCProtocol?
    private let authManager = AuthManager()
    private let validation = ValidationManager()

    init(view: any EditProfileVCProtocol) {
        self.view = view
    }

    func saveChanges(email: String, password: String) {
        saveChangesInFirebase(email: email, password: password)
        saveChangesInCoreData()
    }

    func saveChangesInFirebase(email: String, password: String) {
        updateEmail(with: email)
        updatePassword(with: password)
    }

    func saveChangesInCoreData(email: String, name: String) {
        print ("change data in coredata")
        self?.view?.
    }

    func updateName(with newName: String) {
        // code
    }

    func updateEmail(with newEmail: String) {
        authManager.updateEmail(to: newEmail) { [weak self] success, error in
            if let error = error {
                self?.view?.showEmailError(message: error.localizedDescription)
                print(error.localizedDescription)
                return
            }

            if success {
                self?.view?.showSuccess(message: "Email updated successfully!")
            } else {
                self?.view?.showEmailError(message: "Failed to update email.")
            }
        }
    }

    func updatePassword(with newPassword: String) {
        authManager.passwordChange(with: newPassword) { [weak self] success, error in
            if let error = error {
                self?.view?.showPasswordError(message: error.localizedDescription)
                return
            }

            if success {
                self?.view?.showSuccess(message: "Email updated successfully!")
            } else {
                self?.view?.showPasswordError(message: "Failed to update email.")
            }
        }
    }

    func changeImage() {
        view?.showImagePicker()
    }

    func didSelectImage(_ image: UIImage) {
        view?.updateProfilePhoto(with: image)
    }
}

