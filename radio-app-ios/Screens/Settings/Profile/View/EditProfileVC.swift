//
//  Profile.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

    // MARK: EditProfileVC Protocol

protocol EditProfileVCProtocol: AnyObject {
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
    }
}
