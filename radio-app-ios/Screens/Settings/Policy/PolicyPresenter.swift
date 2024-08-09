//
//  PolicyPresenter.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 08.08.2024.
//

import UIKit

protocol PolicyPresenterProtocol {
    init(view: PolicyVCProtocol)
}

final class PolicyPresenter: PolicyPresenterProtocol {

    private weak var view: PolicyVCProtocol?

    init(view: PolicyVCProtocol) {
        self.view = view
    }

}

