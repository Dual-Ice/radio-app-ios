//
//  Endpoints.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 31.07.2024.
//

import Foundation

enum Endpoints {
    case getPopular
    case getSingleStation (uuids: String)           /// "uuids" means "id"
    case getCountriesList
    case getLanguagesList
    case getTags
    case doSearch (request: String)

    var path: String {
        switch self {
        case .getPopular:
            return "/json/stations/topvote"
        case .getSingleStation(uuids: let uuids):
            return "/json/stations/byuuid/\(uuids)"
        case .getCountriesList:
            return "/json/countries"
        case .getLanguagesList:
            return "/json/languages"
        case .getTags:
            return "/json/tags"
        case .doSearch(request: let request):
            return "/json/stations/search"
        }
    }
}
