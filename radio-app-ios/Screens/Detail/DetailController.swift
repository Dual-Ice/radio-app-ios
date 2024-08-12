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
        AudioPleer.shared.delegate = self
        detailView.setUserAvatar(UserManager.shared.getUserProfileData().image)
        updateUI(isFavorite: presenter.isFavorite)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        detailView.playerControler.update()
        detailView.volumeControler.update()
        if AudioPleer.shared.isPlaying {
            detailView.waveAnimationView.startAnimation()
        }
        presenter.onWillAppear { [unowned self] in
            updateUI(isFavorite: presenter.isFavorite)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        detailView.waveAnimationView.stopAnimation()
    }
    
    func updateUI(isFavorite: Bool) {
        detailView.configureUI(with: presenter.currentStation, isFavorite: isFavorite)
    }
}

//MARK: - DetailViewDelegate
extension DetailController: DetailViewDelegate {
    func profileButtonTapped() {
        presenter.goToProfileSettings()
    }
    
    func arrowButtonTapped() {
        presenter.goBack()
    }
    
    func addFavoriteButtonTapped() {
        presenter.vote()
        updateUI(isFavorite: presenter.isFavorite)
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

//MARK: - AudioPleerDelegate
extension DetailController: AudioPleerDelegate {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ОК", comment: ""), style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
