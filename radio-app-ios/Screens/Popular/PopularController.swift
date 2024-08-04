//
//  ViewController.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 29.07.2024.
//

import UIKit

final class PopularController: UIViewController {
    
    private let popularView = PopularView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = popularView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popularView.setDelegates(self)
    }


}

extension PopularController: PopularViewDelegate {
    func tappedButton() {
        print("Button is tapped")
    }
    
}

