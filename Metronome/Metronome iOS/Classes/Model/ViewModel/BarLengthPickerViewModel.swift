//
//  BarLengthPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct BarLengthPickerViewModel: GesturePickerViewModel {

    let backgroundColor: String
    let titleLabel: String
    let prefixLabel: String
    let suffixLabel: String
    let heroLabel: String

    init(timeSignature: TimeSignature) {
        backgroundColor = "orange"
        titleLabel = NSLocalizedString("metronome.time_signature.bar_length.picker.title", comment: "")
        prefixLabel = ""
        suffixLabel = String(format: NSLocalizedString("metronome.time_signature.bar_length.picker.suffix.format", comment: ""), timeSignature.noteLength.rawValue)
        heroLabel = String(timeSignature.beats)
    }
}
