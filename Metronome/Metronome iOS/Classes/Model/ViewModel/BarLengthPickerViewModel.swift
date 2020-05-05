//
//  BarLengthPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct BarLengthPickerViewModel: GesturePickerViewModel {

    let backgroundColor: Palette
    let titleLabel: String
    let prefixLabel: String
    let suffixLabel: String
    let heroLabel: String

    init(timeSignature: TimeSignature) {
        backgroundColor = .orange
        titleLabel = Copy.TimeSignature.barLength.localised
        prefixLabel = ""
        suffixLabel = String(format: Copy.TimeSignature.barLengthSuffixFormat.localised, timeSignature.noteLength.rawValue)
        heroLabel = String(timeSignature.beats)
    }
}
