//
//  NoteLengthPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 14/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct NoteLengthPickerViewModel: GesturePickerViewModel {

    let backgroundColor: Palette
    let titleLabel: String
    let prefixLabel: String
    let suffixLabel: String
    let heroLabel: String

    init(timeSignature: TimeSignature) {
        backgroundColor = .purple
        titleLabel = Copy.TimeSignature.noteLength.localised
        prefixLabel = String(format: Copy.TimeSignature.noteLengthPrefixFormat.localised, timeSignature.beats)
        suffixLabel = ""
        heroLabel = String(timeSignature.noteLength.rawValue)
    }
}
