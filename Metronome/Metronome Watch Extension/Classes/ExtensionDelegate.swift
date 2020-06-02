//
//  ExtensionDelegate.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                if let configuration = try? DictionaryDecoder().decode(MetronomeConfiguration.self, from:  backgroundTask.userInfo) {
                    (WKExtension.shared().rootInterfaceController as? MetronomeHostingController)?.update(with: configuration)
                }
                backgroundTask.setTaskCompletedWithSnapshot(true)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                if let configuration = try? DictionaryDecoder().decode(MetronomeConfiguration.self, from:  snapshotTask.userInfo) {
                    (WKExtension.shared().rootInterfaceController as? MetronomeHostingController)?.update(with: configuration)
                }
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                if let configuration = try? DictionaryDecoder().decode(MetronomeConfiguration.self, from:  connectivityTask.userInfo) {
                    (WKExtension.shared().rootInterfaceController as? MetronomeHostingController)?.update(with: configuration)
                }
                connectivityTask.setTaskCompletedWithSnapshot(true)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                if let configuration = try? DictionaryDecoder().decode(MetronomeConfiguration.self, from:  relevantShortcutTask.userInfo) {
                    (WKExtension.shared().rootInterfaceController as? MetronomeHostingController)?.update(with: configuration)
                }
                relevantShortcutTask.setTaskCompletedWithSnapshot(true)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }

}
