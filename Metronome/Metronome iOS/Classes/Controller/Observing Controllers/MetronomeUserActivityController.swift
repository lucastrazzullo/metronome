//
//  MetronomeUserActivityController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 11/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class MetronomeUserActivityController: NSObject, ObservingController {

    // MARK: Instance properties

    private var setupMetronomeUserActivity: NSUserActivity?
    private var startMetronomeUserActivity: NSUserActivity?
    private var cancellables: [AnyCancellable] = []

    private let metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome
        super.init()
    }


    // MARK: Public methods

    func set(publisher: MetronomePublisher) {
        cancellables.append(publisher.$configuration.sink { [weak self] configuration in
            self?.setupMetronomeUserActivity = UserActivityFactory.buildActivity(for: .configureMetronome, with: configuration)
            self?.setupMetronomeUserActivity?.becomeCurrent()

            self?.startMetronomeUserActivity = UserActivityFactory.buildActivity(for: .startMetronome, with: configuration)
            self?.startMetronomeUserActivity?.delegate = self
        })

        cancellables.append(publisher.$isRunning.sink { [weak self] isRunning in
            if isRunning {
                self?.startMetronomeUserActivity?.becomeCurrent()
            } else {
                self?.setupMetronomeUserActivity?.becomeCurrent()
            }
        })
    }
}


extension MetronomeUserActivityController: NSUserActivityDelegate {

    func userActivityWasContinued(_ userActivity: NSUserActivity) {
        metronome.reset()
    }
}
