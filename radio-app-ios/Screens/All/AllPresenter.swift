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
    private var backupStations: [Station] = .init()
    
    private var cellDotColors: [IndexPath: UIColor] = [:]
    private var selectedIndexPath: IndexPath? = IndexPath(row: 0, section: 0)
    private var favoriteStations: Set<String> = []
    var isSearching = false
    
    init(allRoute: AllRouter) {
        self.allRoute = allRoute
    }
    
    func goToDetail(by index: Int) {
        AudioPleer.shared.loadStationList(stations)
        if AudioPleer.shared.currentURL != stations[index].url {
            AudioPleer.shared.loadStation(at: index)
        }
        allRoute.goToDetail(station: stations[index])
    }
    
    func goToSettings() {
        allRoute.goToSettings()
    }
    
    func getStations() -> [Station] {
        return stations
    }
    
    func getColorMap() -> [IndexPath: UIColor] {
        return cellDotColors
    }
    
    func onWillAppear(completion: @escaping () -> Void) {
        loadFavoriteStations(completion: completion)
        if AudioPleer.shared.currentURL.isEmpty {
            AudioPleer.shared.loadStationList(self.stations)
        }
    }
    
    func onLoad() {
        fetchAllStations { [weak self] success in
            guard let self = self else { return }
            
            if success {
                if self.stations.count > 0 {
                    self.cellDotColors = StationHelper.makeDotColorsForStations(stations: self.stations)
                    if AudioPleer.shared.currentURL.isEmpty {
                        AudioPleer.shared.loadStationList(self.stations)
                    }
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
    
    func vote(for stationuuid: String) {
        guard let station = stations.first(where: { $0.stationuuid == stationuuid }) else {
            print("Station not found")
            return
        }
        
        let hasVoted = UserManager.shared.hasVoted(for: stationuuid)
        let isFavorite = favoriteStations.contains(stationuuid)
        
        let action: (@escaping (Error?) -> Void) -> Void = { completion in
            if isFavorite {
                UserManager.shared.removeFromFavorite(stationUid: stationuuid) { error in
                    completion(error)
                }
                self.favoriteStations.remove(stationuuid)
            } else {
                UserManager.shared.addToFavorite(station: station) { error in
                    completion(error)
                }
                self.favoriteStations.insert(stationuuid)
            }
        }
        action { [weak self] error in
            if let error = error {
                print("Failed to update favorites: \(error)")
                return
            }
            
            if !isFavorite && !hasVoted {
                self?.sendVote(for: stationuuid)
            }
            
            DispatchQueue.main.async {
                self?.allVC?.refreshData()
            }
        }
    }
        
    private func sendVote(for stationID: String) {
        apiManager.voteForStation(stationID: stationID) { [weak self] result in
            switch result {
            case .success(let vote):
                if vote.ok == true {
                    DispatchQueue.main.async {
                        self?.updateStationVoteCount(stationID: stationID)
                        UserManager.shared.markAsVoted(stationUid: stationID)
                        self?.allVC?.refreshData()
                        
                    }
                } else {
                    print("Vote failed: \(vote.message ?? "No message")")
                }
            case .failure(let error):
                print("Vote request failed: \(error)")
            }
        }
    }
    
    private func updateStationVoteCount(stationID: String) {
        guard let index = stations.firstIndex(where: { $0.stationuuid == stationID }) else { return }
            
        if let currentVotes = stations[index].votes {
            stations[index].votes = currentVotes + 1
        } else {
            stations[index].votes = 1
        }
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

    func searchStations(with query: String) {
        apiManager.doSearch(request: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let stations):
                    if self?.backupStations.count == 0 {
                        self?.backupStations = self?.stations ?? []
                    }
                    self?.stations = stations
                    self?.isSearching = true
                    self?.allVC?.refreshData()
                case .failure(let error):
                    print("Ошибка поиска: \(error)")
                }
            }
        }
    }
    
    func rollbackStations() {
        isSearching = false
        stations = backupStations
        backupStations = []
        allVC?.refreshData()
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
