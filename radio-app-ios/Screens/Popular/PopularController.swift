//
//  PopularController.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 01.08.2024.
//

import UIKit

final class PopularController: UIViewController {
    
    private let popularView = PopularView()
    private let apiManager = Radio_API_Manager()
    private var stations = [Station]() {
        didSet {
            popularView.getCollectionView.reloadData()
        }
    }
    private var selectedIndexPath: IndexPath? = IndexPath(row: 0, section: 0)
    private let dotColors: [UIColor] = [.red, .blue, .green, .purple, .yellow, .systemCyan, .orange]
    private var cellDotColors: [IndexPath: UIColor] = [:]
    
    // MARK: - Life Cycle
    override func loadView() {
        view = popularView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popularView.setDelegates(self)
        fetchPopularStations()
        
        // MARK: - Заменить на данные с профиля
        if let profileImage = UIImage(named: "onboardingBackground") {
            popularView.configureHeader(with: "Mark", profileImage: profileImage)
        }
    }
    
    private func fetchPopularStations() {
        apiManager.getPopular { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let stations):
                    self?.stations = stations
                    for (index, _) in stations.enumerated() {
                        let indexPath = IndexPath(row: index, section: 0)
                        self?.cellDotColors[indexPath] = self?.dotColors[index % (self?.dotColors.count ?? 1)]
                    }
                case .failure(let error):
                    print("Failed to featch popular stations: \(error)")
                }
            }
        }
    }
}

extension PopularController: HeaderViewDelegate {
    func profileTapped() {
        print("go to profile")
    }
}

extension PopularController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.identifier, for: indexPath) as? PopularCell else {
            return UICollectionViewCell()
        }
        
        let station = stations[indexPath.row]
        let isActive = indexPath == selectedIndexPath
        let dotColor = cellDotColors[indexPath] ?? .red
        cell.configure(
            with: station.tags ?? "Unknow Genre",
            subtitle: station.name ?? "Unknow Station",
            votes: station.votes ?? 0,
            isActive: isActive,
            dotColor: dotColor
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        popularView.getCollectionView.reloadData()
        print("Selected cell at \(indexPath)")
    }
    // MARK: - Активировать когда будет метод
//    func vote(for stationuuid: String) {
//        apiManager.vote(for: stationuuid) { [weak self] result in
//            switch result {
//            case .success:
//                print("Vote registered for station \(stationuuid)")
//            case .failure(let error):
//                print("Failed to register vote: \(error)")
//            }
//        }
//    }
}
