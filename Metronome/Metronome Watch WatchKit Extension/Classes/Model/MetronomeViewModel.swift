//
//  MetronomeViewModel.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct MetronomeViewModel {

    private var isRunning: Bool = false
    private var currentBit: Int?

    private var configuration: MetronomeConfiguration


    // MARK: Object life cycle

    init(configuration: MetronomeConfiguration) {
        self.configuration = configuration
    }


    // MARK: Getters

    var bits: [BitViewModel] {
        return Array(0..<configuration.timeSignature.bits).map({ BitViewModel(index: $0, label: String($0 + 1)) })
    }


    var currentBitIndex: Int? {
        return currentBit != nil ? currentBit! - 1 : nil
    }


    var timeSignatureLabel: String {
        return "\(configuration.timeSignature.bits)/\(configuration.timeSignature.noteLength.rawValue)"
    }


    var tempoLabel: String {
        return "\(configuration.tempo.bpm)BPM"
    }


    var toggleLabel: String {
        return isRunning ? "Reset" : "Start"
    }


    // MARK: Mutating methods

    mutating func set(isRunning: Bool) {
        self.isRunning = isRunning
    }


    mutating func set(currentBit: Int?) {
        self.currentBit = currentBit
    }


    mutating func set(tempo: Tempo) {
        self.configuration.tempo = tempo
    }


    mutating func set(timesignature: TimeSignature) {
        self.configuration.timeSignature = timesignature
    }
}
