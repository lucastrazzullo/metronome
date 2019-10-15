//
//  TapTempoUpdaterViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 14/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct TapTempoUpdaterViewModel: UpdaterViewModel {

    var tempo: Tempo


    // Getters

    var backgroundColor: String {
        return "green"
    }

    var titleLabel: String {
        return NSLocalizedString("metronome.tempo.updater.tap.title", comment: "")
    }

    var prefixLabel: String {
        return ""
    }

    var heroLabel: String {
        return String(tempo.bpm)
    }

    var suffixLabel: String {
        return NSLocalizedString("metronome.tempo.suffix", comment: "")
    }
}
