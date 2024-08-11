//
//  Network Struct.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 31.07.2024.
//

import Foundation

/// model for getting stations
struct Station: Codable, Equatable {
    let name: String?
    let stationuuid: String?
    let url: String?            /// link to the station to listen to music
    let tags: String?           /// genre of the station
    let favicon: String?        /// icon of the station
    var votes: Int?             /// raiting of the station
    let country: String?        /// country the station belongs to, multistring
    let language: String?       /// spoken languages, multistring
    let geo_lat: Double?        /// частота? часто прилетает nil
    let freq = String(format: "%.1f%", Double.random(in: 87.5...108.0))
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

struct Vote: Codable {
    let ok: Bool?               /// true if succeeded
    let message: String?
}
