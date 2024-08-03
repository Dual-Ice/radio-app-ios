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
    static let firestoreManager = FirestoreManager()
    private var user: User?
    
    private init() {}
    
    func setUser(userObject: User) {
        user = userObject
    }
    
    func updateUserAvatar(avatar: UIImage, completion: @escaping (Error?) -> Void) {
        if let base64String = avatar.pngData()?.base64EncodedString() {
            let pathToAvatar = saveUserAvatarToUD(with: user?.id ?? "", avatar: base64String)
            user?.image = pathToAvatar
            DispatchQueue.main.async {
                UserManager.firestoreManager.setCollection(
                    with: self.user!
                ) { success, error in
                    if let error = error {
                        completion(error)
                    }
                    
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
    
    private func makeUserImage() -> UIImage? {
        guard let imageData = getUserAvatarFromUD(by: user?.id ?? ""), !imageData.isEmpty else {
            return nil
        }
            
        guard let imageDataDecoded = Data(base64Encoded: imageData) else {
            return nil
        }
        
        return UIImage(data: imageDataDecoded)
    }
    
    private func getKeyForUserAvatar(by userId: String) -> String {
        return "user-" + userId + "-avatar"
    }
    
    private func saveUserAvatarToUD(with userId: String, avatar: String) -> String {
        let key = getKeyForUserAvatar(by: userId)
        UserDefaults.standard.set(avatar, forKey: key)
        return key
    }
    
    private func getUserAvatarFromUD(by userId: String) -> String? {
        let key = getKeyForUserAvatar(by: userId)
        let defaults = UserDefaults.standard
            
        guard let avatarString = defaults.string(forKey: key) else {
            return nil
        }
        
        return avatarString
    }
}

