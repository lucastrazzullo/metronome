//
//  BarLengthPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class BarLengthPickerViewModel: GesturePickerViewModel {

    private(set) var selectedTimeSignature: TimeSignature
    private let initialTimeSignature: TimeSignature


    // MARK: Object life cycle

    init(timeSignature: TimeSignature) {
        selectedTimeSignature = timeSignature
        initialTimeSignature = timeSignature

        let value = String(timeSignature.beats)
        let background = Palette.orange
        let title = Copy.TimeSignature.barLength.localised
        let suffix = String(format: Copy.TimeSignature.barLengthSuffixFormat.localised, timeSignature.noteLength.rawValue)
        super.init(value: value, background: background, title: title, prefix: nil, suffix: suffix)
    }


    // MARK: Public methods

    func apply(barLength offset: Int) {
        let beats = initialTimeSignature.beats + (offset / 32)
        selectedTimeSignature = TimeSignature(beats: beats, noteLength: initialTimeSignature.noteLength)
        heroLabel = String(beats)
    }
}
