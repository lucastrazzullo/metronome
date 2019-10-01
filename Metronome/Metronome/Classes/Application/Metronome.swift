//
//  Metronome.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

protocol MetronomeDelegate: AnyObject {
    func metronome(_ metronome: Metronome, didTick bit: Int)
}


protocol MetronomeStatusDelegate: AnyObject {
    func metronomeDidStart(_ metronome: Metronome)
    func metronomeDidReset(_ metronome: Metronome)
    func metronome(_ metronome: Metronome, didUpdate tempo: Tempo, timeSignature: TimeSignature)
}


class Metronome {

    weak var delegate: MetronomeDelegate?
    weak var statusDelegate: MetronomeStatusDelegate?

    var tempo: Tempo {
        didSet {
            statusDelegate?.metronome(self, didUpdate: tempo, timeSignature: timeSignature)
        }
    }
    var timeSignature: TimeSignature {
        didSet {
            statusDelegate?.metronome(self, didUpdate: tempo, timeSignature: timeSignature)
        }
   }

    private var timer: Timer?
    private var tickIteration: Int = 0


    // MARK: Public getters

    var isRunning: Bool {
        return timer?.isValid ?? false
    }


    var currentBit: Int {
        return getCurrentBit()
    }


    // MARK: Object life cycle

    init() {
        self.tempo = Tempo.default
        self.timeSignature = TimeSignature.default
    }


    // MARK: Public methods

    func start() {
        timer = Timer.scheduledTimer(timeInterval: getTimeInterval(), target: self, selector: #selector(didTick), userInfo: nil, repeats: true)
        statusDelegate?.metronomeDidStart(self)
    }


    func reset() {
        timer?.invalidate()
        timer = nil

        tickIteration = 0
        statusDelegate?.metronomeDidReset(self)
    }


    // MARK: Actions

    @objc private func didTick() {
        delegate?.metronome(self, didTick: getCurrentBit())
        tickIteration += 1
    }


    // MARK: Private helper methods

    private func getCurrentBit() -> Int {
        return tickIteration % timeSignature.bits + 1
    }


    private func getTimeInterval() -> TimeInterval {
        return Double(60) / Double(tempo.bpm) / (Double(timeSignature.noteLength) / Double(4))
    }
}
