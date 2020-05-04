//
//  NoteLengthPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 14/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct NoteLengthPickerViewModel: GesturePickerViewModel {

    let backgroundColor: String
    let titleLabel: String
    let prefixLabel: String
    let suffixLabel: String
    let heroLabel: String

    init(timeSignature: TimeSignature) {
        backgroundColor = "purple"
        titleLabel = NSLocalizedString("metronome.time_signature.note_length.picker.title", comment: "")
        prefixLabel = String(format: NSLocalizedString("metronome.time_signature.note_length.picker.prefix.format", comment: ""), timeSignature.beats)
        suffixLabel = ""
        heroLabel = String(timeSignature.noteLength.rawValue)
    }
}
