//
//  SlideTempoPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct SlideTempoPickerViewModel: GesturePickerViewModel {

    let backgroundColor: String
    let titleLabel: String
    let prefixLabel: String
    let suffixLabel: String
    let heroLabel: String

    init(bpm: Int) {
        backgroundColor = "yellow"
        titleLabel = NSLocalizedString("metronome.tempo.picker.title", comment: "")
        prefixLabel = ""
        suffixLabel = NSLocalizedString("metronome.tempo.suffix", comment: "")
        heroLabel = String(bpm)
    }
}
