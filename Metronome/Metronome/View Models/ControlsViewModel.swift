//
//  ControlsViewModel.swift
//  Metronome
//
//  Created by luca strazzullo on 3/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

struct ControlsViewModel {

    var timeSignatureLabel: String
    var tempoLabel: String
    var toggleLabel: String


    // MARK: Object life cycle

    init(with configuration: MetronomeConfiguration, isRunning: Bool) {
        timeSignatureLabel = String(format: NSLocalizedString("metronome.time_signature.format", comment: ""), configuration.timeSignature.beats, configuration.timeSignature.noteLength.rawValue)
        tempoLabel = String(format: "%d%@", configuration.tempo.bpm, NSLocalizedString("metronome.tempo.suffix", comment: "").uppercased())
        toggleLabel = isRunning ? "Reset" : "Start"
    }
}
