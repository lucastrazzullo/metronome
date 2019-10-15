//
//  SlideTempoUpdaterViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct SlideTempoUpdaterViewModel: UpdaterViewModel {

    var tempo: Tempo


    // Getters

    var backgroundColor: String {
        return "yellow"
    }

    var titleLabel: String {
        return NSLocalizedString("metronome.tempo.updater.title", comment: "")
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
