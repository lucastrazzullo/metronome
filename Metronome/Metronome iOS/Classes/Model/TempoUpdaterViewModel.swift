//
//  TempoUpdaterViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct TempoUpdaterViewModel {

    var tempo: Tempo


    // Getters

    var tempoLabel: String {
        return String(format: NSLocalizedString("metronome.tempo.format", comment: ""), tempo.bpm)
    }
}
