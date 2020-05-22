//
//  CacheController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 21/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class CacheController: MetronomeObserver {

    private let stateCache: MetronomeStateCache
    private var cancellables: [AnyCancellable]


    // MARK: Object life cycle

    init(cache: MetronomeStateCache) {
        self.stateCache = cache
        self.cancellables = []
    }


    // MARK: Public methods

    func set(publisher: MetronomePublisher) {
        cancellables.append(publisher.$configuration.sink { [weak self] configuration in
            self?.cacheConfigurationValues(configuration: configuration)
        })
        cancellables.append(publisher.$isSoundOn.sink { [weak self] isSoundOn in
            self?.cacheIsSoundOn(isSoundOn)
        })
    }


    // MARK: Private helper methods

    private func cacheConfigurationValues(configuration: MetronomeConfiguration) {
        stateCache.barLength = configuration.timeSignature.barLength
        stateCache.noteLength = configuration.timeSignature.noteLength
        stateCache.bpm = configuration.tempo.bpm
    }


    private func cacheIsSoundOn(_ isSoundOn: Bool) {
        stateCache.isSoundOn = isSoundOn
    }
}
