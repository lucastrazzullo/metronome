//
//  BarLengthUpdaterViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct BarLengthUpdaterViewModel: UpdaterViewModel {

    let backgroundColor: String = "orange"
    let titleLabel: String = NSLocalizedString("metronome.time_signature.bar_length.updater.title", comment: "")
    let prefixLabel: String = ""
    let heroLabel: String
    let suffixLabel: String

    init(timeSignature: TimeSignature) {
        heroLabel = String(timeSignature.beats)
        suffixLabel = String(format: NSLocalizedString("metronome.time_signature.bar_length.updater.suffix.format", comment: ""), timeSignature.noteLength.rawValue)
    }
}
