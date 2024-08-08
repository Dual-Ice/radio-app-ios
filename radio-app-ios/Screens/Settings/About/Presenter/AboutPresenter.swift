//
//  AboutPresenter.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 08.08.2024.
//

import UIKit

protocol AboutPresenterProtocol {
    init(view: AboutVCProtocol)
}

final class AboutPresenter: AboutPresenterProtocol {


    private weak var view: AboutVCProtocol?

    init(view: AboutVCProtocol) {
        self.view = view
    }

}

