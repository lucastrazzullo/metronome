//
//  SnapshotMetronomePublisher.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 18/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Combine

class SnapshotMetronomePublisher<SnapshotType: SnapshotMetronomePublisherModel>: MetronomeObserver, ObservableObject {

    @Published var snapshot: SnapshotType

    var metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome
        self.snapshot = SnapshotType(from: metronome)
    }
}


extension SnapshotMetronomePublisher {

    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
        snapshot.configuration = configuration
    }


    func metronome(_ metronome: Metronome, didPulse beat: MetronomeBeat) {
        snapshot.currentBeat = beat
    }


    func metronome(_ metronome: Metronome, willStartWithSuspended beat: MetronomeBeat?) {
        snapshot.isRunning = true
        snapshot.currentBeat = beat
    }


    func metronome(_ metronome: Metronome, willResetDuring beat: MetronomeBeat?) {
        snapshot.isRunning = false
        snapshot.currentBeat = beat
    }
}
