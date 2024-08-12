//
//  Network Struct.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 31.07.2024.
//

import Foundation

/// model for getting stations
class Station: Codable, Equatable {
    let name: String?
    let stationuuid: String?
    let url: String?            /// link to the station to listen to music
    let tags: String?           /// genre of the station
    let favicon: String?        /// icon of the station
    var votes: Int?             /// raiting of the station
    let country: String?        /// country the station belongs to, multistring
    let language: String?       /// spoken languages, multistring
    let geo_lat: Double?        /// частота? часто прилетает nil
    let freq: String?
    
    // MARK: - Equatable Conformance
    
    static func == (lhs: Station, rhs: Station) -> Bool {
        return lhs.stationuuid == rhs.stationuuid
    }
    
    init(name: String?, stationuuid: String?, url: String?, tags: String?, favicon: String?, votes: Int?, country: String?, language: String?, geo_lat: Double?, freq: String?) {
        self.name = name
        self.stationuuid = stationuuid
        self.url = url
        self.tags = tags
        self.favicon = favicon
        self.votes = votes
        self.country = country
        self.language = language
        self.geo_lat = geo_lat
        self.freq = freq ?? String(format: "%.1f%", Double.random(in: 87.5...108.0))
    }
    enum CodingKeys: String, CodingKey {
        case name
        case stationuuid
        case url
        case tags
        case favicon
        case votes
        case country
        case language
        case geo_lat
        case freq
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.stationuuid = try container.decodeIfPresent(String.self, forKey: .stationuuid)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.tags = try container.decodeIfPresent(String.self, forKey: .tags)
        self.favicon = try container.decodeIfPresent(String.self, forKey: .favicon)
        self.votes = try container.decodeIfPresent(Int.self, forKey: .votes)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.geo_lat = try container.decodeIfPresent(Double.self, forKey: .geo_lat)
        self.freq = try container.decodeIfPresent(String.self, forKey: .freq) ?? String(format: "%.1f%", Double.random(in: 87.5...108.0))
    }
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
