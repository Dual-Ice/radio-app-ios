//
//  PopularController.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 01.08.2024.
//

import UIKit


final class PopularController: UIViewController {
    
    private let popularView = PopularView()
    
    private let presenter: PopularPresenter
    
    init(presenter: PopularPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = popularView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popularView.setDelegates(popularVD: self, playerVD: self)
        presenter.onLoad()
        
        // MARK: - Заменить на данные с профиля
        if let profileImage = UIImage(named: "onboardingBackground") {
            popularView.configureHeader(with: "Mark", profileImage: profileImage)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.onWillAppear {
            self.refreshData()
        }
        
        popularView.playerControler.update()
        popularView.volumeControler.update()
    }
    
    func refreshData() {
        popularView.getCollectionView.reloadData()
    }
}

extension PopularController: HeaderViewDelegate {
    func profileTapped() {
        presenter.goToSettings()
    }
}

extension PopularController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getStations().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.identifier, for: indexPath) as? PopularCell else {
            return UICollectionViewCell()
        }
        
        let stationData = presenter.getStationData(by: indexPath)
        cell.configure(with: stationData)
        cell.setDelegate(self)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.updateSelected(with: indexPath)
        refreshData()
        presenter.goToDetail(by: indexPath.row)
    }
}

extension PopularController: PopularCellDelegate {
    
    func vote(for stationuuid: String) {
        presenter.vote(for: stationuuid)
    }
}

//MARK: - Player Controller Delegate
extension PopularController: PlayerControlDelegate {
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
