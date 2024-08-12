//
//  Profile.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

    // MARK: NotificationsVC Protocol

protocol NotificationsVCProtocol: AnyObject {
}

    // MARK: NotificationsVC

final class NotificationsVC: UIViewController, NotificationsVCProtocol {

    var presenter: NotificationsPresenterProtocol!

    // MARK: UI Elements

    private let notificationView = NotificationsView()

    // MARK: Life cycle

    override func loadView() {
        view = notificationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
