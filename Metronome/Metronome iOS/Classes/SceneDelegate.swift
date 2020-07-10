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
            let configuration = try? DictionaryDecoder().decode(MetronomeConfiguration.self, from: userInfo) {
            (UIApplication.shared.delegate as? AppDelegate)?.shortcutItemToProcess = nil
            (window?.rootViewController as? MetronomeViewController)?.startMetronome(with: configuration)
        }
    }


    func sceneDidEnterBackground(_ scene: UIScene) {
        (window?.rootViewController as? MetronomeViewController)?.resetMetronome()
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
                                             userInfo: try? DictionaryEncoder().encode(configuration))
        }
    }


    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        (UIApplication.shared.delegate as? AppDelegate)?.shortcutItemToProcess = shortcutItem
    }


    // MARK: User Activity

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard let activity = ActivityType(rawValue: userActivity.activityType) else { return }
        guard let userInfo = userActivity.userInfo else { return }
        guard let configuration = try? DictionaryDecoder().decode(MetronomeConfiguration.self, from: userInfo) else { return }
        switch activity {
        case .configureMetronome:
            (window?.rootViewController as? MetronomeViewController)?.setupMetronome(with: configuration)
        case .startMetronome:
            (window?.rootViewController as? MetronomeViewController)?.startMetronome(with: configuration)
        }
    }
}

