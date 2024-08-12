//
//  FavoriteStation+CoreDataProperties.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 05.08.2024.
//
//

import Foundation
import CoreData


extension FavoriteStation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteStation> {
        return NSFetchRequest<FavoriteStation>(entityName: "FavoriteStation")
    }

    @NSManaged public var name: String?
    @NSManaged public var stationuuid: String?
    @NSManaged public var url: String?
    @NSManaged public var tags: String?
    @NSManaged public var favicon: String?
    @NSManaged public var votes: Int64
    @NSManaged public var country: String?
    @NSManaged public var language: String?
    @NSManaged public var geo_lat: Double
    @NSManaged public var user_id: String?
    @NSManaged public var freq: String?

}

extension FavoriteStation : Identifiable {

}
