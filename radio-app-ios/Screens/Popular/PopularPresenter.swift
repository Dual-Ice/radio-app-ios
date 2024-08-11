//
//  PopularPresenter.swift
//  radio-app-ios
//
//  Created by nik on 10.08.24.
//

import Foundation

final class PopularPresenter {

    weak var popularVC: PopularController?
    let popularRoute: PopularRouter
    
    init(popularRoute: PopularRouter) {
        self.popularRoute = popularRoute
    }
    
    func goToDetail(station: Station) {
        popularRoute.goToDetail(station: station)
    }

    func goToSettings() {
        popularRoute.goToSettings()
    }
}
