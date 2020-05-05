//
//  TapTempoPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 14/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct TapTempoPickerViewModel: GesturePickerViewModel {

    let backgroundColor: Palette
    let titleLabel: String
    let prefixLabel: String
    let suffixLabel: String
    let heroLabel: String

    init(bpm: Int?) {
        backgroundColor = .green
        titleLabel = Copy.Picker.TapTempo.title.localised
        prefixLabel = ""
        suffixLabel = Copy.Tempo.unit.localised
        if let bpm = bpm {
            heroLabel = String(bpm)
        } else {
            heroLabel = Copy.Picker.TapTempo.valuePlaceholder.localised
        }
    }
}
