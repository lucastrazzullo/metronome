//
//  MetronomeTicker.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

protocol MetronomeTickerDelegate: AnyObject {
    func metronomeTickerDidStart(_ ticker: MetronomeTicker)
    func metronomeTickerDidReset(_ ticker: MetronomeTicker)
    func metronomeTicker(_ ticker: MetronomeTicker, didTick iteration: Int)
}


class MetronomeTicker {

    struct Keys {
        static let loopLength = "loopLength"
    }


    // MARK: Instance properties

    weak var delegate: MetronomeTickerDelegate?

    private(set) var iteration: Int?
    private var timer: Timer?


    // MARK: Public getters

    var isRunning: Bool {
        return timer?.isValid ?? false
    }


    // MARK: Public methods

    func start(with timeInterval: TimeInterval, loopLength: Int) {
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(didTick), userInfo: [Keys.loopLength: loopLength], repeats: true)

        delegate?.metronomeTickerDidStart(self)
    }


    func reset() {
        timer?.invalidate()
        timer = nil
        iteration = nil

        delegate?.metronomeTickerDidReset(self)
    }


    // MARK: Actions

    @objc private func didTick() {
        iteration = nextIteration(with: (timer?.userInfo as? [String: Any])?[Keys.loopLength] as? Int)

        delegate?.metronomeTicker(self, didTick: iteration!)
    }


    // MARK: Private helper methods

    private func nextIteration(with loopLength: Int?) -> Int {
        guard let tickIteration = iteration else { return 1 }
        guard let loopLength = loopLength else { return 1 }

        if tickIteration < loopLength {
            return tickIteration + 1
        } else {
            return 1
        }
    }
}
