//
//  NoteLengthUpdaterViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 14/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct NoteLengthUpdaterViewModel: UpdaterViewModel {

    var timeSignature: TimeSignature


    // MARK: Getters

    var backgroundColor: String {
        return "purple"
    }

    var titleLabel: String {
        return NSLocalizedString("metronome.time_signature.note_length.updater.title", comment: "")
    }

    var prefixLabel: String {
        return String(format: NSLocalizedString("metronome.time_signature.note_length.updater.prefix.format", comment: ""), timeSignature.bits)
    }

    var heroLabel: String {
        return String(timeSignature.noteLength.rawValue)
    }

    var suffixLabel: String {
        return ""
    }
}
