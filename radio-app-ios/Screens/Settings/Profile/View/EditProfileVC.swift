//
//  Profile.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

    // MARK: EditProfileVC Protocol

protocol EditProfileVCProtocol: AnyObject {
    func updateProfilePhoto(with: UIImage)
    func showImagePicker()

    func showEmailError(message: String)
    func showPasswordError(message: String)
    func showSuccess(message: String)
}

    // MARK: EditProfileVC

final class EditProfileVC: UIViewController, EditProfileVCProtocol {

    var presenter: EditProfilePresenterProtocol!
    let alertManager = AuthAlertManager()

    // MARK: UI Elements

    private let editProfileView = EditProfileView()

    // MARK: Life cycle

    override func loadView() {
        view = editProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }

    // MARK: Public methods

    func showEmailError(message: String) {
        alertManager.showDefaultAlert(on: self,
                                      title: "Email error",
                                      message: message)
    }

    func showPasswordError(message: String) {
        alertManager.showDefaultAlert(on: self,
                                      title: "Password error",
                                      message: message)
    }

    func showSuccess(message: String) {
        alertManager.showDefaultAlert(on: self,
                                      title: "Success",
                                      message: message)
    }

    func showImagePicker() {
        setupImagePicker()
    }

    func updateProfilePhoto(with image: UIImage) {
        editProfileView.updatePhoto(with: image)
    }

    // MARK: Private methods

    private func setDelegate() {
        editProfileView.delegate = self
    }
}

    // MARK: Work with EditProfile Delegate

extension EditProfileVC: EditProfileViewDelegate {
    
    func saveButtonTapped(email: String, password: String)  {
        presenter.saveChanges(email: email, password: password)
    }

    func editImageButtonTapped() {
        presenter.changeImage()
    }
}
