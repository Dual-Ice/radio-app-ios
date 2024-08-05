//
//  AppDelegate.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 29.07.2024.
//

import UIKit
import FirebaseCore
import Firebase
import GoogleSignIn
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var coreDataManager: CoreDataManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        coreDataManager = CoreDataManager()
        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }
    
    // for google signin
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        coreDataManager?.saveContext { error in
            if let error = error {
                // Логируем ошибку, если необходимо
                print("Failed to save context: \(error)")
            }
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        coreDataManager?.saveContext { error in
            if let error = error {
                // Логируем ошибку, если необходимо
                print("Failed to save context: \(error)")
            }
        }
    }
}

