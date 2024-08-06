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
    case doSearchByCountry (parameter: String)
    case doSearchByLanguageOrTag (parameter: String)

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
        case .doSearch:
            return "/json/stations/search"
        case .doSearchByCountry:
            return "/json/stations/search"
        case .doSearchByLanguageOrTag:
            return "/json/stations/search"
        }
    }
}