//
//  ObservableMetronome.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Combine

class ObservableMetronome<SnapshotType: ObservableMetronomeSnapshot>: Metronome, ObservableObject {

    @Published private(set) var snapshot: SnapshotType!


    // MARK: Object life cycle

    override init(with configuration: MetronomeConfiguration) {
        super.init(with: configuration)

        snapshot = SnapshotType(with: self)
        delegate = self
        tickerDelegate = self
    }
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
