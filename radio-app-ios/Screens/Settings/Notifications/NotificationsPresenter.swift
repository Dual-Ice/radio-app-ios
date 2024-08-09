//
//  MainSettingsPresenter.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 08.08.2024.
//

import UIKit

protocol NotificationsPresenterProtocol {
    init(view: NotificationsVCProtocol)
}

final class NotificationsPresenter: NotificationsPresenterProtocol {

    private weak var view: NotificationsVCProtocol?

    init(view: NotificationsVCProtocol) {
        self.view = view
    }
}
