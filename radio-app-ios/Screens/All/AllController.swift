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
        allView.setDelegates(allVD: self, playerVD: self)
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
        allView.updateUI(forEmptyState: presenter.getStations().count == 0, with: presenter.isSearching)
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

//MARK: - AllStationCellDelegate
extension AllController: AllStationCellDelegate {
    func vote(for stationuuid: String) {
        presenter.vote(for: stationuuid)
    }
}

//MARK: - Player Controller Delegate
extension AllController: PlayerControlDelegate {
    func nextButtonTapped() {
        presenter.nextStation()
    }
    
    func backButtonTapped() {
        presenter.previousStation()
    }
}

extension AllController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let query = searchBar.text, query.isEmpty {
            searchBar.text = nil
            searchBar.resignFirstResponder()
            allView.switchHeader(false)
            presenter.rollbackStations()
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text, !query.isEmpty {
            allView.switchHeader(true)
            presenter.searchStations(with: query)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        allView.switchHeader(false)
        presenter.rollbackStations()
    }
}
