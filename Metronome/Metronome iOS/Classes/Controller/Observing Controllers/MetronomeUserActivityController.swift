//
//  MetronomeUserActivityController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 11/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class MetronomeUserActivityController: ObservingController {

    // MARK: Instance properties

    private var startMetronomeActivity: NSUserActivity?
    private var cancellables: [AnyCancellable] = []


    // MARK: Public methods

    func set(publisher: MetronomePublisher) {
        cancellables.append(publisher.$configuration.sink { [weak self] configuration in
            self?.startMetronomeActivity = UserActivityFactory.buildStartMetronomeActivity(for: configuration)
        })

        cancellables.append(publisher.$isRunning.sink { [weak self] isRunning in
            if isRunning { self?.startMetronomeActivity?.becomeCurrent() }
            else { self?.startMetronomeActivity?.resignCurrent() }
        })
    }
}
