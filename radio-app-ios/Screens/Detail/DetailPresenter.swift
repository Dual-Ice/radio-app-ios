//
//  DetailPresenter.swift
//  radio-app-ios
//
//  Created by Maksim on 01.08.2024.
//

import Foundation

class DetailPresenter {
    
    private var currentStation: Station
    private let router: DetailRouterProtocol
    weak var view: DetailController?
    
    init(data: Station, router: DetailRouter) {
        self.currentStation = data
        self.router = router
    }
    
    func getCurrentStation() -> Station {
        return currentStation
    }
    
    func goBack() {
        router.dismiss()
    }
    
    func goToProfileSettings() {
        router.goToProfileSettings()
    }
}