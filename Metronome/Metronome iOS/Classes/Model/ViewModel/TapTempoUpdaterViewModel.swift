//
//  TapTempoUpdaterViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 14/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct TapTempoUpdaterViewModel: UpdaterViewModel {

    let backgroundColor: String = "green"
    let titleLabel: String = NSLocalizedString("metronome.tempo.updater.tap.title", comment: "")
    let prefixLabel: String = ""
    let heroLabel: String
    let suffixLabel: String = NSLocalizedString("metronome.tempo.suffix", comment: "")

    init(bpm: Int?) {
        if let bpm = bpm {
            heroLabel = String(bpm)
        } else {
            heroLabel = NSLocalizedString("metronome.tempo.updater.tap.hero.placeholder", comment: "")
        }
    }
}
