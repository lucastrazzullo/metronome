//
//  MultiObservingController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 5/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

protocol ObservingController {
    func set(publisher: MetronomePublisher)
}


class MultiObservingController {

    private let cache: MetronomeStateCache
    private var controllers: [ObservingController] = []


    // MARK: Object life cycle

    init(cache: MetronomeStateCache) {
        self.cache = cache
        self.controllers = buildControllers()
    }


    // MARK: Public methods

    func set(publisher: MetronomePublisher) {
        controllers.forEach() { controller in
            controller.set(publisher: publisher)
        }
    }


    // MARK: Private helper methods

    private func buildControllers() -> [ObservingController] {
        let metronomeApplicationSettingsController = MetronomeApplicationSettingsController()
        let metronomeHapticController = MetronomeHapticController()
        let metronomeCacheController = MetronomeCacheController(cache: cache)
        let metronomeSoundController = MetronomeSoundController()

        return [
            metronomeApplicationSettingsController,
            metronomeHapticController,
            metronomeCacheController,
            metronomeSoundController
        ]
    }
}
