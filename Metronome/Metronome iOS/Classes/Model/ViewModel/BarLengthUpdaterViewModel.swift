//
//  BarLengthUpdaterViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct BarLengthUpdaterViewModel: UpdaterViewModel {

    var timeSignature: TimeSignature


    // MARK: Getters

    var backgroundColor: String {
        return "orange"
    }

    var titleLabel: String {
        return NSLocalizedString("metronome.time_signature.bar_length.updater.title", comment: "")
    }

    var prefixLabel: String {
        return ""
    }

    var heroLabel: String {
        return String(timeSignature.bits)
    }

    var suffixLabel: String {
        String(format: NSLocalizedString("metronome.time_signature.bar_length.updater.suffix.format", comment: ""), timeSignature.noteLength.rawValue)
    }
}
