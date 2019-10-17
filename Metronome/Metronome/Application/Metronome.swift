//
//  Metronome.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

protocol MetronomeDelegate: AnyObject {
    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration)
    func metronome(_ metronome: Metronome, didTick iteration: Int)
    func metronome(_ metronome: Metronome, didStartAt iteration: Int)
    func metronome(_ metronome: Metronome, didResetAt iteration: Int)
}


class Metronome {

    weak var delegate: MetronomeDelegate?

    var configuration: MetronomeConfiguration {
        didSet {
            reset()
            delegate?.metronome(self, didUpdate: configuration)
        }
    }

    private var ticker: MetronomeTicker


    // MARK: Public getters

    var isRunning: Bool {
        return ticker.isRunning
    }


    var currentIteration: Int {
        return ticker.iteration
    }


    // MARK: Object life cycle

    init(with configuration: MetronomeConfiguration) {
        self.configuration = configuration
        self.ticker = MetronomeTicker()
        self.ticker.delegate = self
    }


    // MARK: Public methods

    func start() {
        ticker.start(with: configuration.getTimeInterval(), loopLength: configuration.timeSignature.bits)
    }


    func reset() {
        ticker.reset()
    }


    func toggle() {
        if isRunning { reset() } else { start() }
    }
}


extension Metronome: MetronomeTickerDelegate {

    func metronomeTickerDidStart(_ ticker: MetronomeTicker) {
        delegate?.metronome(self, didStartAt: ticker.iteration)
    }


    func metronomeTickerDidReset(_ ticker: MetronomeTicker) {
        delegate?.metronome(self, didResetAt: ticker.iteration)
    }


    func metronomeTicker(_ ticker: MetronomeTicker, didTick iteration: Int) {
        delegate?.metronome(self, didTick: iteration)
    }
}
