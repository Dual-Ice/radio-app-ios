//
//  AllController.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 11.08.2024.
//

import UIKit

final class AllController: UIViewController {
    
    private let allView = AllView()
    private let presenter: AllPresenter
    
    init(presenter: AllPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func loadView() {
        view = allView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allView.setDelegates(self)
        presenter.onLoad()
        
        if let profileImage = UIImage(named: "onboardingBackground") {
            allView.configureHeader(with: "Mark", profileImage: profileImage)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.onWillAppear {
            self.refreshData()
        }
    }
    
    func refreshData() {
        allView.getCollectionView.reloadData()
    }
    
}

// MARK: - Header Delegate
extension AllController: HeaderViewDelegate {
    func profileTapped() {
        print("go to profile")
    }
}

// MARK: - AllController DataSource and Delegate
extension AllController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getStations().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllStationCell.identifier, for: indexPath) as? AllStationCell else {
            return UICollectionViewCell()
        }
        
        let stationData = presenter.getStationData(by: indexPath)
        
        cell.genreStation.text = stationData.genre
        cell.nameStation.text = stationData.name
        cell.votes.text = "votes \(stationData.votes)"

        if !stationData.isActive {
            cell.contentView.layer.borderColor = Color.customGray.cgColor
            cell.playingStatus.isHidden = true
            cell.imageHeart.image = UIImage(named: "heartDeselected")
            cell.contentView.backgroundColor = .clear
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.updateSelected(with: indexPath)
        refreshData()
        presenter.goToDetail(by: indexPath.row)
    }
}
