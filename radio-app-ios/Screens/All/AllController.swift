//
//  AllController.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 07.08.2024.
//

import UIKit

final class AllController: UIViewController {
    
    private let allView = AllView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = allView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allView.setDelegates(self)
    }


}

extension AllController: AllViewDelegate {
    func tappedButton() {
        print("Button is tapped")
    }
    
}





