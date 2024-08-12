//
//  FavoritesController.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 30.07.2024.
//

import UIKit

final class FavoritesController: UIViewController {

    private let favoritesView = FavoritesView()
    
    private let presenter: FavoritesPresenter
    
    init(presenter: FavoritesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func loadView() {
        view = favoritesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesView.setDelegates(favoriteVD: self, playerVD: self)
        
        // MARK: - Заменить на данные с профиля
        if let profileImage = UIImage(named: "onboardingBackground") {
            favoritesView.configureHeader(with: "Mark", profileImage: profileImage)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.onWillAppear()
        favoritesView.playerControler.update()
        favoritesView.volumeControler.update()
    }
    
    func refreshData() {
        favoritesView.collectionView.reloadData()
        favoritesView.updateUI(forEmptyState: presenter.getFavoriteStations().count == 0)
    }
}

extension FavoritesController: HeaderViewDelegate {
    func profileTapped() {
        presenter.goToSettings()
    }
}

extension FavoritesController: FavoriteCellDelegate {
    func tappedButtonWith(stationUid: String) {
        presenter.removeStationFromFavorite(with: stationUid)
    }
}

extension FavoritesController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getFavoriteStations().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else {
            return UICollectionViewCell()
        }
        
        
        let stationData = presenter.getStationData(by: indexPath)
        cell.configure(with: stationData)
        cell.setDelegate(self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.goToDetail(by: indexPath.row)
    }
}

//MARK: - Player Controller Delegate
extension FavoritesController: PlayerControlDelegate {
    func playButtonTapped() {
        refreshData()
    }
    
    func pauseButtonTapped() {
        refreshData()
    }
    
    func nextButtonTapped() {
        presenter.nextStation()
    }
    
    func backButtonTapped() {
        presenter.previousStation()
    }
}

// MARK: - Preview
//@available(iOS 17, *)
//#Preview {
//    FavoritesController()
//}
