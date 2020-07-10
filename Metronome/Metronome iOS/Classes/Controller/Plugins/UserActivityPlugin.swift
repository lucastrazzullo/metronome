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


    // MARK: Object life cycle

    init(controller: SessionController) {
        self.controller = controller
        super.init()
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


extension UserActivityPlugin: ApplicationStateAwarePlugin {

    func applicationDidEnterForeground() {
        setupMetronomeUserActivity?.becomeCurrent()
    }


    func applicationDidEnterForefroundNotificationName() -> NSNotification.Name {
        return UIScene.willEnterForegroundNotification
    }


    func applicationDidEnterBackground() {
        setupMetronomeUserActivity?.resignCurrent()
        startMetronomeUserActivity?.resignCurrent()
    }


    func applicationDidEnterBackgroundNotificationName() -> NSNotification.Name {
        return UIScene.didEnterBackgroundNotification
    }
}
