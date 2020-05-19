//
//  TimerBackedMetronomeTicker.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 8/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

class TimerBackedMetronomeTicker: MetronomeTicker {

    // MARK: Instance properties

    weak var delegate: MetronomeTickerDelegate?

    private var timer: Timer?
    private var timeInterval: TimeInterval?
    private var lastTick: CFAbsoluteTime = 0


    // MARK: Public getters

    var isRunning: Bool {
        return timer?.isValid ?? false
    }


    // MARK: Public methods

    func start(with timeInterval: TimeInterval) {
        delegate?.metronomeTickerWillStart(self)

        self.lastTick = CFAbsoluteTimeGetCurrent()
        self.timeInterval = timeInterval
        self.timer = Timer.scheduledTimer(timeInterval: timeInterval * 0.01, target: self, selector: #selector(didTick), userInfo: nil, repeats: true)
    }


    func reset() {
        delegate?.metronomeTickerWillReset(self)

        timeInterval = nil
        timer?.invalidate()
        timer = nil
    }


    // MARK: Actions

    @objc private func didTick(timer: Timer) {
        guard let timeInterval = timeInterval else { return }
        let elapsedTime: CFAbsoluteTime = CFAbsoluteTimeGetCurrent() - lastTick
        if (elapsedTime > timeInterval) || (abs(elapsedTime - timeInterval) < 0.003) {
            lastTick = CFAbsoluteTimeGetCurrent()
            delegate?.metronomeTickerDidTick(self)
        }
    }
}
