//
//  ExtensionDelegate.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import WatchKit
import ClockKit
import Combine

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    let sessionController: RemoteSessionController = RemoteSessionController()
    var cancellables: Set<AnyCancellable> = []


    // MARK: Application life cycle

    func applicationDidFinishLaunching() {
        sessionController.sessionPublisher
            .map { $0.configuration }
            .removeDuplicates()
            .sink { [weak self] configuration in
                let server = CLKComplicationServer.sharedInstance()
                for complication in server.activeComplications ?? [] {
                    server.reloadTimeline(for: complication)
                }

                if let targetDate = self?.nextReloadTime(after: Date()) {
                    WKExtension.shared().scheduleBackgroundRefresh(
                        withPreferredDate: targetDate,
                        userInfo: nil,
                        scheduledCompletion: { _ in }
                    )
                }
            }
            .store(in: &cancellables)
    }


    // MARK: Background life cycle

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        for task in backgroundTasks {
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                if let snapshot = try? DictionaryDecoder().decode(MetronomeSession.Snapshot.self, from: backgroundTask.userInfo) {
                    sessionController.set(snapshot: snapshot)
                }
                backgroundTask.setTaskCompletedWithSnapshot(true)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                if let snapshot = try? DictionaryDecoder().decode(MetronomeSession.Snapshot.self, from: snapshotTask.userInfo) {
                    sessionController.set(snapshot: snapshot)
                }
                let expirationDate = nextReloadTime(after: Date())
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: expirationDate, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                if let snapshot = try? DictionaryDecoder().decode(MetronomeSession.Snapshot.self, from: connectivityTask.userInfo) {
                    sessionController.set(snapshot: snapshot)
                }
                connectivityTask.setTaskCompletedWithSnapshot(true)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                if let snapshot = try? DictionaryDecoder().decode(MetronomeSession.Snapshot.self, from: relevantShortcutTask.userInfo) {
                    sessionController.set(snapshot: snapshot)
                }
                relevantShortcutTask.setTaskCompletedWithSnapshot(true)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }


    // MARK: Private helper methods

    private func nextReloadTime(after date: Date) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let targetMinutes = DateComponents(minute: 15)

        var nextReloadTime = calendar.nextDate(
            after: date,
            matching: targetMinutes,
            matchingPolicy: .nextTime
        )!

        if nextReloadTime.timeIntervalSince(date) < 5 * 60 {
            nextReloadTime.addTimeInterval(3600)
        }

        return nextReloadTime
    }
}
