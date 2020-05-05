//
//  MetronomeCacheController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 21/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class MetronomeCacheController: ObservingController {

    private let configurationCache: ConfigurationCache

    private var cancellable: AnyCancellable?


    // MARK: Object life cycle

    init(cache: ConfigurationCache) {
        self.configurationCache = cache
    }


    // MARK: Public methods

    func set(publisher: MetronomePublisher) {
        cancellable = publisher.$configuration.sink { [weak self] configuration in
            self?.cacheConfigurationValues(configuration: configuration)
        }
    }


    // MARK: Private helper methods

    private func cacheConfigurationValues(configuration: MetronomeConfiguration) {
        configurationCache.barLength = configuration.timeSignature.beats
        configurationCache.noteLength = configuration.timeSignature.noteLength
        configurationCache.bpm = configuration.tempo.bpm
    }
}
