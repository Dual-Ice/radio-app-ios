//
//  DetailPresenter.swift
//  radio-app-ios
//
//  Created by Maksim on 01.08.2024.
//

import Foundation

class DetailPresenter {
    
    var data: Datan
    weak var view: DetailController?
    
    init(data: Datan) {
        self.data = data
    }
    
    func getData() -> Datan {
        return data
    }
}
