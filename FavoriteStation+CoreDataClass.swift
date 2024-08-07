//
//  FavoriteStation+CoreDataClass.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 05.08.2024.
//
//

import Foundation
import CoreData


public class FavoriteStation: NSManagedObject {

}

extension FavoriteStation {
    func toStation() -> Station {
        return Station(
            name: self.name,
            stationuuid: self.stationuuid,
            url: self.url,
            tags: self.tags,
            favicon: self.favicon,
            votes: Int(self.votes),
            country: self.country,
            language: self.language,
            geo_lat: self.geo_lat
        )
    }
}
