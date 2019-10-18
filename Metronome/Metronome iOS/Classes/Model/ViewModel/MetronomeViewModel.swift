//
//  MetronomeViewModel.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct MetronomeViewModel: SnapshotMetronomePublisherModel {

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
        return String(format: NSLocalizedString("metronome.time_signature.format", comment: ""), configuration.timeSignature.bits, configuration.timeSignature.noteLength.rawValue)
    }


    var tempoLabel: String {
        return String(format: "%d%@", configuration.tempo.bpm, NSLocalizedString("metronome.tempo.suffix", comment: "").uppercased())
    }
}
