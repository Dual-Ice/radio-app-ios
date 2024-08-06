//
//  User.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 01.08.2024.
//

import Foundation

struct User {
    let id: String
    var username: String = ""
    var email: String = ""
    var image: String?
}

extension User: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        username = try container.decode(String.self, forKey: .username)
        email = try container.decode(String.self, forKey: .email)
        id = try container.decode(String.self, forKey: .id)
        image = try container.decode(String.self, forKey: .image)
    }
}

extension User {
    func toJSON() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}



