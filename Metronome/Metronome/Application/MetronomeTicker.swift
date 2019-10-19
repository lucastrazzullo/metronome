//
//  MetronomeTicker.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

protocol MetronomeTickerDelegate: AnyObject {
    func metronomeTicker(_ ticker: MetronomeTicker, willStartWithSuspended iteration: Int?)
    func metronomeTicker(_ ticker: MetronomeTicker, willResetDuring iteration: Int?)
    func metronomeTicker(_ ticker: MetronomeTicker, didTick iteration: Int)
}


class MetronomeTicker {

    struct Keys {
        static let loopLength = "loopLength"
    }


    // MARK: Instance properties

    weak var delegate: MetronomeTickerDelegate?

    private(set) var currentIteration: Int?
    private var timer: Timer?


    // MARK: Public getters

    var isRunning: Bool {
        return timer?.isValid ?? false
    }


    // MARK: Public methods

    func start(with timeInterval: TimeInterval, loopLength: Int) {
        delegate?.metronomeTicker(self, willStartWithSuspended: currentIteration)

        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(didTick), userInfo: [Keys.loopLength: loopLength], repeats: true)
    }


    func reset() {
        delegate?.metronomeTicker(self, willResetDuring: currentIteration)

        timer?.invalidate()
        timer = nil

        currentIteration = nil
    }


    // MARK: Actions

    @objc private func didTick() {
        let iteration = nextIteration(with: (timer?.userInfo as! [String: Any])[Keys.loopLength] as! Int)
        self.currentIteration = iteration

        delegate?.metronomeTicker(self, didTick: iteration)
    }


    // MARK: Private helper methods

    private func nextIteration(with loopLength: Int) -> Int {
        guard let iteration = currentIteration else { return 0 }

        if iteration + 1 < loopLength {
            return iteration + 1
        } else {
            return 0
        }
    }
}
