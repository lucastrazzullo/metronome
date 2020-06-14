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

    func metronome(_ metronome: Metronome, willStartWithSuspended beat: Beat?)
    func metronome(_ metronome: Metronome, willResetAt beat: Beat?)
    func metronome(_ metronome: Metronome, didPulse beat: Beat)
}


class Metronome {

    weak var delegate: MetronomeDelegate?

    var configuration: MetronomeConfiguration {
        didSet {
            ticker.update(timeInterval: configuration.getTimeInterval())
            delegate?.metronome(self, didUpdate: configuration)
        }
    }

    var isSoundOn: Bool {
        didSet {
            delegate?.metronome(self, didUpdate: isSoundOn)
        }
    }

    var isRunning: Bool {
        return ticker.isRunning
    }

    var currentBeat: Beat?

    private var ticker: MetronomeTicker


    // MARK: Object life cycle

    init(with configuration: MetronomeConfiguration, soundOn: Bool) {
        self.isSoundOn = soundOn
        self.configuration = configuration
        self.ticker = TimerBackedMetronomeTicker()
        self.ticker.delegate = self
    }


    // MARK: Public methods

    func start() {
        ticker.start(with: configuration.getTimeInterval())
    }


    func reset() {
        ticker.reset()
        currentBeat = nil
    }


    func toggle() {
        if isRunning {
            reset()
        } else {
            start()
        }
    }


    // MARK: Private helper methods

    private func nextBeat() -> Beat {
        guard let currentBeat = currentBeat else { return configuration.timeSignature.barLength.beats[0] }
        if currentBeat.position + 1 < configuration.timeSignature.barLength.numberOfBeats {
            return configuration.timeSignature.barLength.beats[currentBeat.position + 1]
        } else {
            return configuration.timeSignature.barLength.beats[0]
        }
    }
}


extension Metronome: MetronomeTickerDelegate {

    func metronomeTickerWillStart(_ ticker: MetronomeTicker) {
        delegate?.metronome(self, willStartWithSuspended: currentBeat)
    }


    func metronomeTickerWillReset(_ ticker: MetronomeTicker) {
        delegate?.metronome(self, willResetAt: currentBeat)
    }


    func metronomeTickerDidTick(_ ticker: MetronomeTicker) {
        currentBeat = nextBeat()

        if let beat = currentBeat {
            delegate?.metronome(self, didPulse: beat)
        }
    }
}
