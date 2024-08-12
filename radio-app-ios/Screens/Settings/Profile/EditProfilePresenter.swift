//
//  EditProfilePresenter.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 08.08.2024.
//

import UIKit

protocol EditProfilePresenterProtocol {
    init(view: EditProfileVCProtocol)
    func saveChanges()
    func changeImage()
    func didSelectImage(_ image: UIImage)
}

final class EditProfilePresenter: EditProfilePresenterProtocol {

    private weak var view: EditProfileVCProtocol?

    init(view: any EditProfileVCProtocol) {
        self.view = view
    }

    func saveChanges() {
        // code
    }

    func changeImage() {
        view?.showImagePicker()
    }

    func didSelectImage(_ image: UIImage) {
        view?.updateProfilePhoto(with: image)
    }
}

