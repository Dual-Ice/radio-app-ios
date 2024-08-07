//
//  RadioUser+CoreDataClass.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 05.08.2024.
//
//

import Foundation
import CoreData


public class RadioUser: NSManagedObject {

}

extension RadioUser {
    func toUser() -> User {
        return User(
            id: self.id!,
            username: self.username!,
            email: self.email!,
            image: self.image
        )
    }
}
