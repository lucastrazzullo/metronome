//
//  ChromeViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 17/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct ChromeViewModel: SnapshotMetronomePublisherModel {

    var configuration: MetronomeConfiguration
    var isRunning: Bool
    var currentIteration: Int


    // MARK: Getters

    var timeSignatureLabel: String {
        return String(format: NSLocalizedString("metronome.time_signature.format", comment: ""), configuration.timeSignature.bits, configuration.timeSignature.noteLength.rawValue)
    }


    var tempoLabel: String {
        return String(format: "%d%@", configuration.tempo.bpm, NSLocalizedString("metronome.tempo.suffix", comment: "").uppercased())
    }
}
