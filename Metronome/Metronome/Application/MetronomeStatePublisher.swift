//
//  MetronomeStatePublisher.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 18/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Combine

class MetronomeStatePublisher {

    struct Snapshot {
        var configuration: MetronomeConfiguration
        var isRunning: Bool
        var currentBeat: Beat?
    }


    // MARK: Instance properties

    @Published var configuration: MetronomeConfiguration
    @Published var isRunning: Bool
    @Published var currentBeat: Beat?

    private(set) var metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.configuration = metronome.configuration
        self.isRunning = metronome.isRunning
        self.currentBeat = metronome.currentBeat
        self.metronome = metronome
        self.metronome.delegate = self
    }


    // MARK: Public methods

    func snapshot() -> Snapshot {
        return Snapshot(configuration: configuration, isRunning: isRunning, currentBeat: currentBeat)
    }


    func snapshotPublisher() -> AnyPublisher<Snapshot, Never> {
        return Publishers.CombineLatest3($configuration, $isRunning, $currentBeat)
            .map(Snapshot.init)
            .eraseToAnyPublisher()
    }
}


extension MetronomeStatePublisher: MetronomeDelegate {

    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
        self.configuration = configuration
    }


    func metronome(_ metronome: Metronome, didPulse beat: Beat) {
        self.currentBeat = beat
    }


    func metronome(_ metronome: Metronome, willStartWithSuspended beat: Beat?) {
        self.isRunning = true
        self.currentBeat = beat
    }


    func metronome(_ metronome: Metronome, willResetDuring beat: Beat?) {
        self.isRunning = false
        self.currentBeat = beat
    }
}
