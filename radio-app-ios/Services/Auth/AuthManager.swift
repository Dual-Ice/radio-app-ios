//
//  AuthManager.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 01.08.2024.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    private let firestoreManager = FirestoreManager()
    
    init() {}
   
    func checkAuth() -> Bool {
        Auth.auth().currentUser != nil
    }
    
    func registerUser(
        with userRequest: RegisterUserRequest,
        completion: @escaping (User?, Error?) -> Void
    ) {
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(
            withEmail: email,
            password: password
        ) { result, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(nil, nil)
                return
            }
            
            let user = User(
                id: resultUser.uid,
                username: username,
                email: email,
                image: ""
            )
            
        
            self.makeUser(user: user) { user, error in
                if let error = error {
                    completion(nil, error)
                } else {
                    completion(user, nil)
                }
            }
        }
    }
    
    func makeUser(user: User, completion: @escaping (User?, Error?) -> Void) {
        firestoreManager.setCollection(
            with: user
        ) { wasSet, error in
            if let error = error {
                completion(nil, error)
            }
            completion(user, nil)
        }
    }
    
    func signInViaEmail(
        with userRequest: LoginUserRequest,
        completion: @escaping (Error?) -> Void
    ) {
        Auth.auth().signIn(
            withEmail: userRequest.email,
            password: userRequest.password
        ) { result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    func signInViaGoogleCredentials(
        with credential: AuthCredential,
        completion: @escaping (Error?) -> Void
    ) {
        Auth.auth().signIn(
            with: credential
        ) { result, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let userID = result?.user.uid else {
                completion(NSError(domain: "AuthError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
                return
            }
            
            self.fetchUser(uid: userID){ existingUser, fetchError in
                
                if existingUser != nil {
                    completion(nil)
                    return
                }
                
                let newUser = User(
                    id: userID,
                    username: result?.user.displayName ?? "User",
                    email: result?.user.email ?? "test@m.com",
                    image: ""
                )
                
                self.makeUser(user: newUser) { user, error in
                    if let error = error {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                }
                
            }
        }
    }
    
    
    func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    func fetchUser(uid: String? = nil, completion: @escaping (User?, Error?) -> Void) {
        let userID: String
            
        if let uid = uid {
            userID = uid
        } else {
            guard let currentUserID = Auth.auth().currentUser?.uid else {
                completion(nil, NSError(domain: "AuthError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
                return
            }
            userID = currentUserID
        }
                
        firestoreManager.fetchCollection(for: userID) { user, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            completion(user, nil)
        }
    }
}

