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
        self.timeSignatureLabel = String(format: Copy.TimeSignature.format.localised, configuration.timeSignature.beats, configuration.timeSignature.noteLength.rawValue)
        self.tempoLabel = "\(configuration.tempo.bpm)\(Copy.Tempo.unit.localised.uppercased())"
        self.toggleLabel = isRunning ? Copy.Controls.reset.localised : Copy.Controls.start.localised
    }
}
