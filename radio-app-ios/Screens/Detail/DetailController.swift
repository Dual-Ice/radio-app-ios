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
    
    //@available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.setDelegates(detailVD: self, playerVD: self)
        detailView.setUserAvatar(UserManager.shared.getUserProfileData().image)
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        detailView.playerControler.update()
        detailView.volumeControler.update()
        if AudioPleer.shared.isPlaying {
            detailView.waveAnimationView.startAnimation()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        detailView.waveAnimationView.stopAnimation()
    }
    
    func updateUI() {
        detailView.configureUI(with: presenter.currentStation)
    }
}

//MARK: - DetailViewDelegate
extension DetailController: DetailViewDelegate {
    func profileButtonTapped() {
        presenter.goToSettings()
    }
    
    func arrowButtonTapped() {
        presenter.goBack()
    }
    
    func addFavoriteButtonTapped() {
        let currentImage = detailView.addFavoriteButton.image(for: .normal)
        
        if currentImage == Image.heartDeselected {
            detailView.addFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            detailView.addFavoriteButton.setImage(
                UIImage(systemName: "heart.fill")?.withTintColor(Color.customPink),
                for: .normal
            )
        }
    }
}

//MARK: - PlayerControlDelegate
extension DetailController: PlayerControlDelegate {
    func playButtonTapped() {
        detailView.waveAnimationView.startAnimation()
    }
    
    func pauseButtonTapped() {
        detailView.waveAnimationView.stopAnimation()
    }
    
    func nextButtonTapped() {
        presenter.nextStation()
    }
    
    func backButtonTapped() {
        presenter.previousStation()
    }
}
