//
//  DetailController.swift
//  radio-app-ios
//
//  Created by Maksim on 30.07.2024.
//

import UIKit

final class DetailController: UIViewController {
    
    private let detailView = DetailView()
    let presenter: DetailPresenter
    
    init (presenter: DetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = detailView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.setDelegates(self)
        presenter.getData()
        print(presenter.getData())
    }


}

extension DetailController: DetailViewDelegate {
    func tappedButton() {
        print("Button is tapped")
    }
    
    
}
