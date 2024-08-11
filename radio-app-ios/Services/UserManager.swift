//
//  UserManager.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 01.08.2024.
//

import UIKit.UIImage

struct UserData {
    let username: String
    let email: String
    let image: UIImage?
}

final class UserManager {
    static let shared = UserManager()
    private var user: User?
    private let coreDataManager = CoreDataManager()
    
    private init() {}
    
    func setUser(userObject: User) {
        user = userObject
    }
    
    func updateUserDetails(username: String, email: String, completion: @escaping (Error?) -> Void) {
        guard let userId = user?.id else {
            let error = NSError(domain: "UserError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])
            completion(error)
            return
        }
        
        coreDataManager.updateUser(id: userId, username: username, email: email, image: user?.image, completion: completion)
    }
    
    func updateUserAvatar(avatar: UIImage, completion: @escaping (Error?) -> Void) {
        guard let userId = user?.id else {
            let error = NSError(domain: "AuthError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
            completion(error)
            return
        }
        
        if let base64String = avatar.pngData()?.base64EncodedString() {
            coreDataManager.updateUser(id: userId, username: user?.username ?? "", email: user?.email ?? "", image: base64String) { error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
        } else {
            let error = NSError(domain: "YourDomain", code: 2, userInfo: [NSLocalizedDescriptionKey: "Error converting image to base64"])
            completion(error)
        }
    }
    
    func getUserProfileData() -> UserData {
        return UserData(
            username: user!.username,
            email: user!.email,
            image: makeUserImage()
        )
    }
    
    func getFavoriteStations(completion: @escaping ([Station], Error?) -> Void) {
        guard let userId = user?.id else {
            completion([], NSError(domain: "AuthError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        
        coreDataManager.getAllStations(forUserId: userId) { favoriteStations, error in
            if let error = error {
                completion([], error)
            } else {
                completion(favoriteStations.map { $0.toStation() }, nil)
            }
        }
    }

    func addToFavorite(station: Station, completion: @escaping (Error?) -> Void) {
        guard let userId = user?.id else {
            completion(NSError(domain: "AuthError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        coreDataManager.addStation(forUserId: userId, stationData: station) { error in
            completion(error)
        }
    }

    func removeFromFavorite(stationUid: String, completion: @escaping (Error?) -> Void) {
        coreDataManager.deleteStation(stationUUID: stationUid) { error in
            completion(error)
        }
    }
    
    private func makeUserImage() -> UIImage? {
        guard let base64String = user?.image, !base64String.isEmpty else {
            return nil
        }
        
        guard let imageData = Data(base64Encoded: base64String) else {
            return nil
        }
        
        return UIImage(data: imageData)
    }
}

