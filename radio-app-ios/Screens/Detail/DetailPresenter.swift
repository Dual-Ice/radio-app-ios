//
//  DetailPresenter.swift
//  radio-app-ios
//
//  Created by Maksim on 01.08.2024.
//

import Foundation

class DetailPresenter {
    private let router: DetailRouter
    private(set) var currentStation: Station
    
    weak var viewController: DetailController?
    
    init(data: Station, router: DetailRouter) {
        self.currentStation = data
        self.router = router
    }
    
    func goBack() {
        router.dismiss()
    }
    
    func goToSettings() {
        router.goToSettings()
    }
    
    func nextStation() {
        AudioPleer.shared.playNext()
        currentStation = AudioPleer.shared.stations[AudioPleer.shared.stationIndex]
        viewController?.updateUI()
    }
    
    func previousStation() {
        AudioPleer.shared.playPrevious()
        currentStation = AudioPleer.shared.stations[AudioPleer.shared.stationIndex]
        viewController?.updateUI()
    }
}
