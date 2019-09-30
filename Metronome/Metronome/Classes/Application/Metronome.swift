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


class Metronome {

    weak var delegate: MetronomeDelegate?

    var tempo: Tempo
    let timeSignature: TimeSignature

    private var timer: Timer?
    private var tickIteration: Int = 0


    // MARK: Object life cycle

    init() {
        self.tempo = Tempo.default
        self.timeSignature = TimeSignature.default
    }


    // MARK: Public methods

    func play() {
        timer = Timer.scheduledTimer(timeInterval: Double(60) / Double(tempo.bpm), target: self, selector: #selector(didTick), userInfo: nil, repeats: true)
    }


    func reset() {
        timer?.invalidate()
        timer = nil

        tickIteration = 0
    }


    // MARK: Actions

    @objc private func didTick() {
        tickIteration += 1
        delegate?.metronome(self, didTick: tickIteration % timeSignature.bits + 1)
    }
}
