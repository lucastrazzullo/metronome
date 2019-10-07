//
//  ObservableMetronome.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Combine

class ObservableMetronome<SnapshotType: MetronomeSnapshot>: ObservableObject {

    @Published private(set) var snapshot: SnapshotType

    let metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome
        self.snapshot = SnapshotType(for: metronome)

        self.metronome.delegate = self
        self.metronome.tickerDelegate = self
    }


    // MARK: Observable

    var didChange = PassthroughSubject<SnapshotType, Never>()
}


extension ObservableMetronome: MetronomeDelegate {

    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
        snapshot.configuration = configuration
    }
}


extension ObservableMetronome: MetronomeTickerDelegate {

    func metronomeTickerDidStart(_ ticker: MetronomeTicker) {
        snapshot.isRunning = true
        snapshot.currentIteration = ticker.iteration
    }

    func metronomeTickerDidReset(_ ticker: MetronomeTicker) {
        snapshot.isRunning = false
        snapshot.currentIteration = ticker.iteration
    }

    func metronomeTicker(_ ticker: MetronomeTicker, didTick iteration: Int) {
        snapshot.currentIteration = iteration
    }
}
