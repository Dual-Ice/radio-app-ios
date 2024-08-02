//
//  Network Struct.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 31.07.2024.
//

import Foundation

/// model for getting stations
struct Station: Codable {                       // почему запросил Codable, не просто Decodable?
    let name: String?
    let stationuuid: String?
    let url: String?            /// link to the station to listen to music
    let tags: String?           /// genre of the station
    let favicon: String?        /// icon of the station
    let votes: Int?             /// raiting of the station
    let country: String?        /// country the station belongs to, multistring
    let language: String?       /// spoken languages, multistring
    let geo_lat: Double?        /// частота? часто прилетает nil
}

/// model for getting list of countries
struct Country: Codable {
    let name: String?
    let iso_3166_1: String?     /// code of the country
    let stationCount: String?   /// how many stations belong to the country, often "nil"
}

/// model for getting list of languages
struct Language: Codable {
    let name: String?
    let stationcount: Int?
}

/// model for getting list of tags a.k.a genres
struct Tag: Codable {
    let name: String?
    let stationcount: Int?
}
