//
//  DetailPresenter.swift
//  radio-app-ios
//
//  Created by Maksim on 01.08.2024.
//

import Foundation

class DetailPresenter {
    private let router: DetailRouter
    private let apiManager = Radio_API_Manager()
    private var favoriteStations: Set<String> = []
    private(set) var currentStation: Station
    var isFavorite: Bool {
        favoriteStations.contains(currentStation.stationuuid ?? "")
    }
    
    weak var viewController: DetailController?
    
    init(data: Station, router: DetailRouter) {
        self.currentStation = data
        self.router = router
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
    
    private func sendVote(for stationID: String) {
        apiManager.voteForStation(stationID: stationID) { [weak self] result in
            switch result {
            case .success(let vote):
                if vote.ok == true {
                    DispatchQueue.main.async {
                        self?.updateStationVoteCount(stationID: stationID)
                        UserManager.shared.markAsVoted(stationUid: stationID)
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
        if let currentVotes = currentStation.votes {
            currentStation.votes = currentVotes + 1
        } else {
            currentStation.votes = 1
        }
    }
    
    func vote() {
        let stationuuid = currentStation.stationuuid ?? ""
        let hasVoted = UserManager.shared.hasVoted(for: stationuuid)
        let isFavorite = favoriteStations.contains(stationuuid)
        
        let action: (@escaping (Error?) -> Void) -> Void = { [unowned self] completion in
            if isFavorite {
                UserManager.shared.removeFromFavorite(stationUid: stationuuid) { error in
                    completion(error)
                }
                self.favoriteStations.remove(stationuuid)
            } else {
                UserManager.shared.addToFavorite(station: currentStation) { error in
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
                self?.viewController?.updateUI(isFavorite: self?.isFavorite ?? false)
            }
        }
    }
    
    func onWillAppear(completion: @escaping () -> Void) {
        loadFavoriteStations(completion: completion)        
    }
    
    func goBack() {
        router.dismiss()
    }
    
    func goToSettings() {
        router.goToSettings()
    }
    
    func nextStation() {
        currentStation = AudioPleer.shared.stations[AudioPleer.shared.stationIndex]
        viewController?.updateUI(isFavorite: isFavorite)
    }
    
    func previousStation() {
        currentStation = AudioPleer.shared.stations[AudioPleer.shared.stationIndex]
        viewController?.updateUI(isFavorite: isFavorite)
    }
}
