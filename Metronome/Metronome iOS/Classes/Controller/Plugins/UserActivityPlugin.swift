//
//  UserActivityPlugin.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 11/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import UIKit
import Combine

class UserActivityPlugin: NSObject, MetronomePlugin {

    // MARK: Instance properties

    weak var controller: SessionController?

    private var setupMetronomeUserActivity: NSUserActivity?
    private var startMetronomeUserActivity: NSUserActivity?

    private var cancellables: [AnyCancellable] = []
    private var observer: NSObjectProtocol?


    // MARK: Object life cycle

    init(controller: SessionController) {
        self.controller = controller
        super.init()
        setupObserver()
    }


    deinit {
        removeObserver()
    }


    // MARK: Application Observer

    private func setupObserver() {
        observer = NotificationCenter.default.addObserver(forName: UIScene.didEnterBackgroundNotification, object: nil, queue: OperationQueue.main, using: {
            [weak self] notification in
            self?.setupMetronomeUserActivity?.resignCurrent()
            self?.startMetronomeUserActivity?.resignCurrent()
        })
    }


    private func removeObserver() {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }


    // MARK: Public methods

    func set(session: MetronomeSession) {
        cancellables.append(session.$configuration.sink { [weak self] configuration in
            self?.setupMetronomeUserActivity = UserActivityFactory.buildActivity(for: .configureMetronome, with: configuration)
            self?.setupMetronomeUserActivity?.becomeCurrent()

            self?.startMetronomeUserActivity = UserActivityFactory.buildActivity(for: .startMetronome, with: configuration)
            self?.startMetronomeUserActivity?.delegate = self
        })

        cancellables.append(session.$isRunning.sink { [weak self] isRunning in
            if isRunning {
                self?.startMetronomeUserActivity?.becomeCurrent()
            } else {
                self?.setupMetronomeUserActivity?.becomeCurrent()
            }
        })
    }
}


extension UserActivityPlugin: NSUserActivityDelegate {

    func userActivityWasContinued(_ userActivity: NSUserActivity) {
        controller?.reset()
    }
}
