//
//  ControlsViewModel.swift
//  Metronome
//
//  Created by luca strazzullo on 3/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

struct ControlsViewModel {

    let timeSignatureLabel: String
    let tempoLabel: String
    let toggleLabel: String


    // MARK: Object life cycle

    init(with configuration: MetronomeConfiguration, isRunning: Bool) {
        self.timeSignatureLabel = String(format: NSLocalizedString("metronome.time_signature.format", comment: ""), configuration.timeSignature.beats, configuration.timeSignature.noteLength.rawValue)
        self.tempoLabel = String(format: "%d%@", configuration.tempo.bpm, NSLocalizedString("metronome.tempo.suffix", comment: "").uppercased())
        self.toggleLabel = isRunning ? "Reset" : "Start"
    }
}
