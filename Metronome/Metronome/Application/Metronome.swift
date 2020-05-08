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
    func metronome(_ metronome: Metronome, didUpdate isSoundOn: Bool)
    func metronome(_ metronome: Metronome, didPulse beat: Beat)
    func metronome(_ metronome: Metronome, willStartWithSuspended beat: Beat?)
    func metronome(_ metronome: Metronome, willResetDuring beat: Beat?)
}


class Metronome {

    weak var delegate: MetronomeDelegate?

    var isSoundOn: Bool {
        didSet {
            delegate?.metronome(self, didUpdate: isSoundOn)
        }
    }
    var configuration: MetronomeConfiguration {
        didSet {
            delegate?.metronome(self, didUpdate: configuration)
        }
    }

    private var ticker: MetronomeTicker


    // MARK: Public getters

    var isRunning: Bool {
        return ticker.isRunning
    }

    var currentBeat: Beat? {
        guard let iteration = ticker.currentIteration else { return nil }
        return Beat.with(tickIteration: iteration)
    }


    // MARK: Object life cycle

    init(with configuration: MetronomeConfiguration, soundOn: Bool) {
        self.isSoundOn = soundOn
        self.configuration = configuration
        self.ticker = MetronomeTicker()
        self.ticker.delegate = self
    }


    // MARK: Public methods

    func start() {
        ticker.start(with: configuration.getTimeInterval(), loopLength: configuration.timeSignature.beats)
    }


    func reset() {
        ticker.reset()
    }


    func toggle() {
        if isRunning { reset() } else { start() }
    }
}


extension Metronome: MetronomeTickerDelegate {

    func metronomeTicker(_ ticker: MetronomeTicker, willStartWithSuspended iteration: Int?) {
        if let iteration = iteration {
            delegate?.metronome(self, willStartWithSuspended: Beat.with(tickIteration: iteration))
        } else {
            delegate?.metronome(self, willStartWithSuspended: nil)
        }
    }


    func metronomeTicker(_ ticker: MetronomeTicker, willResetDuring iteration: Int?) {
        if let iteration = iteration {
            delegate?.metronome(self, willResetDuring: Beat.with(tickIteration: iteration))
        } else {
            delegate?.metronome(self, willResetDuring: nil)
        }
    }


    func metronomeTicker(_ ticker: MetronomeTicker, didTick iteration: Int) {
        delegate?.metronome(self, didPulse: Beat.with(tickIteration: iteration))
    }
}
