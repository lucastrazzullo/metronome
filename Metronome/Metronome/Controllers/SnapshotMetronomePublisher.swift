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


    func metronome(_ metronome: Metronome, didTick iteration: Int) {
        snapshot.currentIteration = iteration
    }


    func metronome(_ metronome: Metronome, didStartAt iteration: Int) {
        snapshot.isRunning = true
        snapshot.currentIteration = iteration
    }


    func metronome(_ metronome: Metronome, didResetAt iteration: Int) {
        snapshot.isRunning = false
        snapshot.currentIteration = iteration
    }
}
