//
//  ObservableMetronome.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Combine

class MetronomeObserver<SnapshotType: MetronomeObserverSnapshot>: ObservableObject {

    @Published private(set) var snapshot: SnapshotType!

    private(set) var metronome: Metronome


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        self.snapshot = SnapshotType(with: metronome)
        self.metronome = metronome
        self.metronome.delegate = self
    }
}


extension MetronomeObserver: MetronomeDelegate {

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
