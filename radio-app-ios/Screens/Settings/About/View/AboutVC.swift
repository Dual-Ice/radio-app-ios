//
//  About.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

    // MARK: AboutVC Protocol

protocol AboutVCProtocol: AnyObject {

}

    // MARK: AboutVC

final class AboutVC: UIViewController, AboutVCProtocol {

    var presenter: AboutPresenterProtocol!

    // MARK: UI Elements

    private let aboutView = AboutView()

    // MARK: Life cycle

    override func loadView() {
        view = aboutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
