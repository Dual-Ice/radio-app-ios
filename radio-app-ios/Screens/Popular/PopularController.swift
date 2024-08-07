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
    private let waveImages: [UIImage] = [
        Image.waveRed!,
        Image.waveBlue!,
        Image.waveGreen!,
        Image.wavePurple!,
        Image.waveYellow!,
        Image.waveLightRed!]
    
    // MARK: - Life Cycle
    override func loadView() {
        view = popularView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popularView.setDelegates(self, dataSource: self)
        fetchPopularStations()
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
}

extension PopularController: PopularViewDelegate {
    
    func cellSelected(at indexPath: IndexPath) {
        selectedIndexPath = indexPath
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
        let isActive = indexPath == selectedIndexPath
        let waveImage = waveImages[indexPath.row % waveImages.count]
        cell.configure(
            with: station.tags ?? "Unknow Genre",
            subtitle: station.name ?? "Unknow Station",
            votes: station.votes ?? 0,
            isActive: isActive,
            waveImage: waveImage
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelected(at: indexPath)
    }
}
