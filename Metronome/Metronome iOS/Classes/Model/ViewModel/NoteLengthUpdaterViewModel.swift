//
//  NoteLengthUpdaterViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 14/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct NoteLengthUpdaterViewModel: UpdaterViewModel {

    let backgroundColor: String = "purple"
    let titleLabel: String = NSLocalizedString("metronome.time_signature.note_length.updater.title", comment: "")
    let prefixLabel: String
    let heroLabel: String
    let suffixLabel: String = ""

    init(timeSignature: TimeSignature) {
        prefixLabel = String(format: NSLocalizedString("metronome.time_signature.note_length.updater.prefix.format", comment: ""), timeSignature.beats)
        heroLabel = String(timeSignature.noteLength.rawValue)
    }
}
