//
//  Endpoints.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 31.07.2024.
//

import Foundation

enum Endpoints {
    case getPopular
    case getAllStations
    case getSingleStation (id: String)
    case search (request: String)

    var path: String {
        switch self {
        case .getPopular:
            return ""
        case .getAllStations:
            return ""
        case .getSingleStation(id: let id):
            return "\(id)"
        case .search(request: let request):
            return "\(request)"
        }
    }
}
