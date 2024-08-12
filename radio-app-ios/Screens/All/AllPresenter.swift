//
//  AllPresenter.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 11.08.2024.
//

import UIKit


final class AllPresenter {
    
    weak var allVC: AllController?
    private let allRoute: AllRouter
    private let apiManager = Radio_API_Manager()
    private var stations: [Station] = .init()
    
    private var cellDotColors: [IndexPath: UIColor] = [:]
    private var selectedIndexPath: IndexPath? = IndexPath(row: 0, section: 0)
    private var favoriteStations: Set<String> = []
    
    init(allRoute: AllRouter) {
        self.allRoute = allRoute
    }
    
    func goToDetail(by index: Int) {
        allRoute.goToDetail(station: stations[index])
    }
    
    func getStations() -> [Station] {
        return stations
    }
    
    func getColorMap() -> [IndexPath: UIColor] {
        return cellDotColors
    }
    
    func onWillAppear(completion: @escaping () -> Void) {
        loadFavoriteStations(completion: completion)
    }
    
    func onLoad() {
        fetchAllStations { [weak self] success in
            guard let self = self else { return }
            
            if success {
                if self.stations.count > 0 {
                    self.cellDotColors = StationHelper.makeDotColorsForStations(stations: self.stations)
                }
                self.allVC?.refreshData()
            } else {
                print("Failed to load popular stations.")
            }
        }
    }
    
    func getStationData(by indexPath: IndexPath) -> StationData {
        let station = stations[indexPath.row]
        let isFavorite = favoriteStations.contains(station.stationuuid ?? "")
        
        return StationData(
            id: station.stationuuid ?? "",
            name: station.name ?? "Unknown station",
            genre: StationHelper.getGenreFromStationTags(station.tags),
            votes: station.votes ?? 0,
            isActive: station.url == AudioPleer.shared.currentURL,
            isPlaying: station.url == AudioPleer.shared.currentURL,
            dotColor: cellDotColors[indexPath] ?? .red,
            isFavorite: isFavorite
        )
    }
    
    func updateSelected(with indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
    
    
    private func loadFavoriteStations(completion: @escaping () -> Void) {
        UserManager.shared.getFavoriteStations { [weak self] (stations, error) in
            if let error = error {
                print("Failed to fetch favorite stations: \(error)")
                completion()
                return
            }
            
            self?.favoriteStations = Set(stations.map { $0.stationuuid ?? "" })
            completion()
        }
    }
    
    private func fetchAllStations(completion: @escaping (_ result: Bool) -> Void) {
        apiManager.getAllStations() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let stations):
                    self?.stations = stations
                    completion(true)
                case .failure(let error):
                    print("Failed to fetch popular stations: \(error)")
                    completion(false)
                }
            }
        }
    }
    
    func vote(for stationuuid: String) {
        print("VOTE for \(stationuuid)")
    }
}

//MARK: - Player Actions
extension AllPresenter {
    func nextStation() {
        allVC?.refreshData()
    }
    
    func previousStation() {
        allVC?.refreshData()
    }
}
