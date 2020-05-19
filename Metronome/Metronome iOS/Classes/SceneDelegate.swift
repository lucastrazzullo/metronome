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


    func sceneDidBecomeActive(_ scene: UIScene) {
        if let shortcutItem = (UIApplication.shared.delegate as? AppDelegate)?.shortcutItemToProcess,
            let userInfo = shortcutItem.userInfo,
            let configuration = UserInfoFactory.configuration(in: userInfo) {
            (UIApplication.shared.delegate as? AppDelegate)?.shortcutItemToProcess = nil
            (window?.rootViewController as? MainViewController)?.startMetronome(with: configuration)
        }
    }


    func sceneDidEnterBackground(_ scene: UIScene) {
        (window?.rootViewController as? MainViewController)?.resetMetronome()
    }


    // MARK: Home Screen Quick Actions

    func sceneWillResignActive(_ scene: UIScene) {
        UIApplication.shared.shortcutItems = TimeSignature.commonDefaults.map { timeSignature in
            let configuration = MetronomeConfiguration(timeSignature: timeSignature, tempo: .default)
            let format = Copy.TimeSignature.format.localised
            let title = String(format: format, timeSignature.barLength.numberOfBeats, timeSignature.noteLength.rawValue)
            let subtitle = Copy.Controls.start.localised
            return UIApplicationShortcutItem(type: "FavoriteAction",
                                             localizedTitle: title,
                                             localizedSubtitle: subtitle,
                                             icon: UIApplicationShortcutIcon(type: .play),
                                             userInfo: UserInfoFactory.userInfo(for: configuration) as? [String : NSSecureCoding])
        }
    }


    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        (UIApplication.shared.delegate as? AppDelegate)?.shortcutItemToProcess = shortcutItem
    }


    // MARK: User Activity

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        if userActivity.activityType == UserActivityFactory.ActivityType.startMetronome.rawValue,
            let userInfo = userActivity.userInfo,
            let configuration = UserInfoFactory.configuration(in: userInfo) {
            (window?.rootViewController as? MainViewController)?.startMetronome(with: configuration)
        }
    }
}

