//
//  PopularController.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 01.08.2024.
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
    
    func cellSelected(at indexPath: IndexPath) {
        print("Selected cell at \(indexPath)")
    }
}
