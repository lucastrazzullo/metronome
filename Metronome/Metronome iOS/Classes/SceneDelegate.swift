//
//  SceneDelegate.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    // MARK: Scene Delegate

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }


    // MARK: User Activity

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        window?.rootViewController?.restoreUserActivityState(userActivity)
    }
}

