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
}

    // MARK: EditProfileVC

final class EditProfileVC: UIViewController, EditProfileVCProtocol {

    var presenter: EditProfilePresenterProtocol!

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
    
    func saveButtonTapped() {
        presenter.saveChanges()
    }

    func editImageButtonTapped() {
        presenter.changeImage()
    }
}
