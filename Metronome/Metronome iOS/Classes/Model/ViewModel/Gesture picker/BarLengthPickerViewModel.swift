//
//  BarLengthPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class BarLengthPickerViewModel: GesturePickerViewModel {

    private let metronome: Metronome
    private var selectedTimeSignature: TimeSignature


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome
        self.selectedTimeSignature = metronome.configuration.timeSignature

        let value = String(selectedTimeSignature.beats)
        let background = Palette.orange
        let title = Copy.TimeSignature.barLength.localised
        let suffix = String(format: Copy.TimeSignature.barLengthSuffixFormat.localised, selectedTimeSignature.noteLength.rawValue)
        super.init(value: value, background: background, title: title, prefix: nil, suffix: suffix)
    }


    // MARK: Public methods

    func startSelection() {
        metronome.reset()
    }


    func selectTemporary(barLength offset: Int) {
        let currentTimeSignature = metronome.configuration.timeSignature
        let beats = max(TimeSignature.minimumBarLength, min(TimeSignature.maximumBarLength, currentTimeSignature.beats + (offset / 32)))
        heroLabel = String(beats)
        selectedTimeSignature = TimeSignature(beats: beats, noteLength: currentTimeSignature.noteLength)
    }


    func commit() {
        metronome.configuration.setTimeSignature(selectedTimeSignature)
    }
}
