//
//  MetronomeViewModel.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct MetronomeViewModel: MetronomeSnapshot {

    var configuration: MetronomeConfiguration
    var isRunning: Bool
    var currentIteration: Int


    // MARK: Getters

    var bits: [BitViewModel] {
        return Array(0..<configuration.timeSignature.bits).map({ BitViewModel(index: $0, label: String($0 + 1)) })
    }


    var currentBitIndex: Int {
        return currentIteration - 1
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
}
