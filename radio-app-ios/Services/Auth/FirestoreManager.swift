//
//  FirestoreManager.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 01.08.2024.
//

import Firebase

final class FirestoreManager {
    
    enum CollectionPath {
        static let username = "username"
        static let email = "email"
        static let image = "image"
    }
    
    static let shared = FirestoreManager()
    
    private let environment = "users"
    private let db = Firestore.firestore()
    
    private init() {}
    
    
    
    func setCollection(
        with user: User,
        completion: @escaping (Bool, Error?) -> Void
    ) {
        db.collection(environment)
            .document(user.id)
            .setData([
                CollectionPath.username: user.username,
                CollectionPath.email: user.email,
                CollectionPath.image: user.image,
            ]) { error in
                if let error = error {
                    print(error)
                    completion(false, error)
                    return
                }
                print("saved")
                completion(true, nil)
            }
    }
    
    func fetchCollection(
        for id: String,
        completion: @escaping (User?, Error?) -> Void
    ) {
        db.collection(environment)
            .document(id)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(nil, error)
                }
                
                guard let snapshot = snapshot, let snapshotData = snapshot.data() else {
                    completion(nil, NSError(domain: "DataError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "No data found"]))
                    return
                }

                do {
                    let username = snapshotData[CollectionPath.username] as? String ?? ""
                    let email = snapshotData[CollectionPath.email] as? String ?? ""
                    let image = snapshotData[CollectionPath.image] as? String ?? ""

                    let user = User(
                        id: id,
                        username: username,
                        email: email,
                        image: image
                    )

                    completion(user, nil)
                } catch {
                    completion(nil, error)
                }
            }
    }
}

