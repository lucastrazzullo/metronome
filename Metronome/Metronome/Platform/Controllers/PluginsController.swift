//
//  MetronomeSessionPluginsController.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 23/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

protocol MetronomePlugin: AnyObject {
    func set(session: MetronomeSession)
}


protocol ApplicationStateAwarePlugin: MetronomePlugin {
    func applicationDidEnterForeground()
    func applicationDidEnterForefroundNotificationName() -> NSNotification.Name

    func applicationDidEnterBackground()
    func applicationDidEnterBackgroundNotificationName() -> NSNotification.Name
}


class PluginsController {

    private let plugins: [MetronomePlugin]

    private var cancellables: Set<AnyCancellable> = []
    private var observers: [NSObjectProtocol] = []


    // MARK: Object life cycle

    init(with pluginList: [MetronomePlugin], sessionController: SessionController) {
        plugins = pluginList
        setupObservers()

        sessionController.sessionPublisher
            .sink(receiveValue: set(session:))
            .store(in: &cancellables)
    }


    deinit {
        removeObservers()
    }


    // MARK: Session

    private func set(session: MetronomeSession) {
        plugins.forEach { plugin in
            plugin.set(session: session)
        }
    }


    // MARK: Application Observer

    private func setupObservers() {
        plugins
            .compactMap { $0 as? ApplicationStateAwarePlugin }
            .forEach { plugin in
                self.observers.append(NotificationCenter.default.addObserver(forName: plugin.applicationDidEnterForefroundNotificationName(), object: nil, queue: OperationQueue.main, using: { [weak plugin] notification in
                    plugin?.applicationDidEnterForeground()
                }))
                self.observers.append(NotificationCenter.default.addObserver(forName: plugin.applicationDidEnterBackgroundNotificationName(), object: nil, queue: OperationQueue.main, using: { [weak plugin] notification in
                    plugin?.applicationDidEnterBackground()
                }))
            }
    }


    private func removeObservers() {
        observers.forEach { observer in
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
