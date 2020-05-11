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
    }


    // MARK: Public methods

    func set(observingControllers: [ObservingController], with publisher: MetronomePublisher) {
        controllers = observingControllers
        controllers.forEach() { controller in
            controller.set(publisher: publisher)
        }
    }
}
