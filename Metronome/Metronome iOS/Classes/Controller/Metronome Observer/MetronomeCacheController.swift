//
//  MetronomeCacheController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 21/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class MetronomeCacheController {

    private let configurationCache: ConfigurationCache


    // MARK: Object life cycle

    init(entry: EntryCache) {
        configurationCache = ConfigurationCache(entry: entry)
    }


    // MARK: Public methods

    func buildConfigurationWithCachedValues() -> MetronomeConfiguration {
        var configuration = MetronomeConfiguration(timeSignature: .default, tempo: .default)
        if let barLength = configurationCache.barLength, let noteLength = configurationCache.noteLength {
            configuration.timeSignature = TimeSignature(beats: barLength, noteLength: noteLength)
        }
        if let bpm = configurationCache.bpm {
            configuration.tempo = Tempo(bpm: bpm)
        }
        return configuration
    }


    func cacheConfigurationValues(configuration: MetronomeConfiguration) {
        configurationCache.barLength = configuration.timeSignature.beats
        configurationCache.noteLength = configuration.timeSignature.noteLength
        configurationCache.bpm = configuration.tempo.bpm
    }
}


extension MetronomeCacheController: MetronomeObserver {

    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
        cacheConfigurationValues(configuration: configuration)
    }


    func metronome(_ metronome: Metronome, didPulse beat: Beat) {
    }


    func metronome(_ metronome: Metronome, willResetDuring beat: Beat?) {
    }


    func metronome(_ metronome: Metronome, willStartWithSuspended beat: Beat?) {
    }
}
