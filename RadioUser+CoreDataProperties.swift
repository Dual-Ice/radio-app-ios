//
//  RadioUser+CoreDataProperties.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 05.08.2024.
//
//

import Foundation
import CoreData


extension RadioUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RadioUser> {
        return NSFetchRequest<RadioUser>(entityName: "RadioUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var username: String?
    @NSManaged public var email: String?
    @NSManaged public var image: String?

}

extension RadioUser : Identifiable {

}
