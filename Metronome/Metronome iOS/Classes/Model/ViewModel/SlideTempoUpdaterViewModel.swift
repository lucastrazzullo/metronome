//
//  SlideTempoUpdaterViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct SlideTempoUpdaterViewModel: UpdaterViewModel {

    let backgroundColor: String = "yellow"
    let titleLabel: String = NSLocalizedString("metronome.tempo.updater.title", comment: "")
    let prefixLabel: String = ""
    let heroLabel: String
    let suffixLabel: String = NSLocalizedString("metronome.tempo.suffix", comment: "")

    init(bpm: Int) {
        heroLabel = String(bpm)
    }
}
