//
//  SceneDelegate.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 29.07.2024.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        
        // Пока нет кнопки выхода - вы можете использовать этот код, чтобы разавторизовать пользователя
//        AuthManager().signOut { error in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//        }
        
//        if UserDefaults.standard.bool(forKey: "isWelcomeCompleted") {
//            checkAuthentication()
//            return
//        }
        
//        window?.rootViewController = LanguageVC()
        let settingsBuilder = MainSettingsBuilder()
        window?.rootViewController = settingsBuilder.createLanguageVC()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

extension SceneDelegate {
    func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            let navigationController = UINavigationController()
            let authBuilder = AuthBuilder(navigationVC: navigationController)
            let authRouter = authBuilder.buildAuthRouter()
            let loginVC = authBuilder.buildAuth(router: authRouter)
            
            navigationController.setViewControllers([loginVC], animated: true)
            window?.rootViewController = navigationController
            return
        }
        
        AuthManager().fetchUser { [weak self] user, error in
            if let error = error {
                print("There is an error signing the user in ==> \(error)")
                return
            }
            
            guard let user = user else { return }
            UserManager.shared.setUser(userObject: user)
            
            self?.window?.rootViewController = PopularController()
        }
    }
}

