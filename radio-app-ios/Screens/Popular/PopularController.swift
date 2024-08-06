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
    
//    private var items = [
//        ("POP", "Radio Record", 315, true, UIImage(named: "waveRed")),
//        ("16bit", "Radio Gameplay", 240, false, UIImage(named: "waveBlue")),
//        ("Punk", "Russian Punk rock", 200, false, UIImage(named: "wavePurple")),
//        ("Dj remix", "IREMIX!", 54, false, UIImage(named: "waveGreen")),
//        ("Adult", "RUSSIAN WAVE", 315, false, UIImage(named: "waveYellow")),
//        ("Etnic", "beufm.kz", 74, false, UIImage(named: "waveLightRed"))
//    ]
    
    // MARK: - Life Cycle
    override func loadView() {
        view = popularView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popularView.setDelegates(self, dataSource: self)
        fetchPopularStations()
//        setupHeaderView()
    }
    
    private func fetchPopularStations() {
        apiManager.getPopular { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let stations):
                    self?.stations = stations
                case .failure(let error):
                    print("Failed to featch popular stations: \(error)")
                }
            }
        }
    }
    
//    private func setupHeaderView() {
////        popularView.headerView.setTitle("Popular")
//    }
}

extension PopularController: PopularViewDelegate {
//    func tappedButton() {
//        print("Button is tapped")
//    }
    
    func cellSelected(at indexPath: IndexPath) {
        for i in 0..<stations.count {
            stations[i].isSelected = (i == indexPath.row)
        }
        popularView.getCollectionView.reloadData()
        print("Selected cell at \(indexPath)")
    }
}

extension PopularController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCell", for: indexPath) as? PopularCell else {
            return UICollectionViewCell()
        }
        
        let station = stations[indexPath.row]
        cell.configure(
            with: station.tags ?? "Unknow Genre",
            subtitle: station.name ?? "Unknow Station",
            votes: station.votes ?? 0,
            isActive: station.isSelected ?? false,
            waveImage: Image.waveLightRed
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelected(at: indexPath)
    }
}
