//
//  DetailController.swift
//  radio-app-ios
//
//  Created by Maksim on 30.07.2024.
//

import UIKit

final class DetailController: UIViewController {
    private let detailView = DetailView()
    private let presenter: DetailPresenter
    
    init (presenter: DetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = detailView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.setDelegates(self)
        detailView.setUserAvatar(UserManager.shared.getUserProfileData().image)
        detailView.configureUI(with: presenter.getCurrentStation())
    }


}

extension DetailController: DetailViewDelegate {
    
    func profileButtonTapped() {
        presenter.goToProfileSettings()
    }
    
    func arrowButtonTapped() {
        presenter.goBack()
    }
    
    func addFavoriteButtonTapped() {
        let currentImage = detailView.addFavoriteButton.image(for: .normal)
        
        if currentImage == Image.heartDeselected {
            detailView.addFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            detailView.addFavoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    func playButtonTapped() {
        print("playButtonTapped")
    }
    
    func playNextButtonTapped() {
        print("playNextButtonTapped")
    }
    
    func playBackButtonTapped() {
        print("playBackButtonTapped")
    }
    
    func volumeSliderChanged(_ sender: UISlider) {
        detailView.percentsLabel.text = "\(Int(sender.value))%"
    }
}
