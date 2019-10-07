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

    private(set) var iteration: Int = 0
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
        iteration = 0

        delegate?.metronomeTickerDidReset(self)
    }


    // MARK: Actions

    @objc private func didTick() {
        iteration = nextIteration(with: (timer?.userInfo as! [String: Any])[Keys.loopLength] as! Int)

        delegate?.metronomeTicker(self, didTick: iteration)
    }


    // MARK: Private helper methods

    private func nextIteration(with loopLength: Int) -> Int {
        guard iteration > 0 else { return 1 }

        if iteration < loopLength {
            return iteration + 1
        } else {
            return 1
        }
    }
}
