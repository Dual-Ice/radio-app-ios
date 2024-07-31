//
//  Network Struct.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 31.07.2024.
//

import Foundation

struct Station {
    let name: String?
    let tags: String?       /// genre of the station
    let favicon: String?    /// icon of the station
    let votes: Int?
    let geo_lat: Double?    /// частота?
//    let bitrate: Int?     /// скорость загрузки 
}
