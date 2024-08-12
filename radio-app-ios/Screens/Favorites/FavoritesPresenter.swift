//
//  FavoritePresenter.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 11.08.2024.
//

import UIKit

struct FavoriteStationData {
    var id: String
    var name: String
    var genre: String
    var dotColor: UIColor
    var isActive: Bool
}

final class FavoritesPresenter {
    
    weak var favoritesVC: FavoritesController?
    private let favoritesRouter: FavoritesRouter
    private var favoriteStations: [Station] = .init()
    private var cellDotColors: [IndexPath: UIColor] = [:]
    
    init(favoritesRouter: FavoritesRouter) {
        self.favoritesRouter = favoritesRouter
    }
    
    func goToDetail(by index: Int) {
        AudioPleer.shared.loadStationList(favoriteStations)
        if AudioPleer.shared.currentURL != favoriteStations[index].url {
            AudioPleer.shared.loadStation(at: index)
        }
        favoritesRouter.goToDetail(station: favoriteStations[index])
    }

    func goToSettings() {
        favoritesRouter.goToSettings()
    }

    func onLoad() {
        loadFavoriteStations()
        favoritesVC?.refreshData()
    }
    
    func onWillAppear (){
        loadFavoriteStations()
        favoritesVC?.refreshData()
    }
    
    func getFavoriteStations() -> [Station] {
        return favoriteStations
    }
    
    func getStationData(by indexPath: IndexPath) -> FavoriteStationData {
        let station = favoriteStations[indexPath.row]

        return FavoriteStationData(
            id: station.stationuuid ?? "",
            name: station.name ?? "Unknown station",
            genre: StationHelper.getGenreFromStationTags(station.tags),
            dotColor: cellDotColors[indexPath] ?? .red,
            isActive: station.url == AudioPleer.shared.currentURL
        )
    }
    
    func removeStationFromFavorite(with stationUid: String) {
        UserManager.shared.removeFromFavorite(stationUid: stationUid) { error in
            if let error = error {
                print("Failed to remove favorite stations: \(error)")
                return
            }
            
            if let index = self.favoriteStations.firstIndex(where: { $0.stationuuid == stationUid }) {
                self.favoriteStations.remove(at: index)
            }
            
            self.favoritesVC?.refreshData()
            
        }
    }
    
    private func loadFavoriteStations (){
        UserManager.shared.getFavoriteStations { [weak self] (stations, error) in
            if let error = error {
                print("Failed to fetch favorite stations: \(error)")
                self?.favoriteStations = []
                return
            }
            
            self?.favoriteStations = stations
            if stations.count > 0 {
                self?.cellDotColors = StationHelper.makeDotColorsForStations(stations: stations)
                if AudioPleer.shared.currentURL.isEmpty {
                    AudioPleer.shared.loadStationList(self?.favoriteStations ?? [])
                }
            }
        }
    }
}

//MARK: - Player Actions
extension FavoritesPresenter {
    func nextStation() {
        favoritesVC?.refreshData()
    }
    
    func previousStation() {
        favoritesVC?.refreshData()
    }
}
