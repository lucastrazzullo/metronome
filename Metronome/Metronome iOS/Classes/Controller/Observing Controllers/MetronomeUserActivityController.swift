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

    private var startMetronomeActivity: NSUserActivity?
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
            self?.startMetronomeActivity = UserActivityFactory.buildStartMetronomeActivity(for: configuration)
            self?.startMetronomeActivity?.delegate = self
        })

        cancellables.append(publisher.$isRunning.sink { [weak self] isRunning in
            if isRunning { self?.startMetronomeActivity?.becomeCurrent() }
            else { self?.startMetronomeActivity?.resignCurrent() }
        })
    }
}


extension MetronomeUserActivityController: NSUserActivityDelegate {

    func userActivityWasContinued(_ userActivity: NSUserActivity) {
        metronome.reset()
    }
}
