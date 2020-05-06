//
//  NoteLengthPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 14/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class NoteLengthPickerViewModel: GesturePickerViewModel {

    private let metronome: Metronome
    private var selectedTimeSignature: TimeSignature


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome
        self.selectedTimeSignature = metronome.configuration.timeSignature

        let value = String(selectedTimeSignature.noteLength.rawValue)
        let background = Palette.purple
        let title = Copy.TimeSignature.noteLength.localised
        let prefix = String(format: Copy.TimeSignature.noteLengthPrefixFormat.localised, selectedTimeSignature.beats)
        super.init(value: value, background: background, title: title, prefix: prefix, suffix: nil)
    }


    // MARK: Public methods

    func startSelection() {
        metronome.reset()
    }


    func selectTemporary(noteLength offset: Int) {
        let currentTimeSignature = metronome.configuration.timeSignature
        let noteLength = currentTimeSignature.noteLength.with(offset: offset)
        heroLabel = String(noteLength.rawValue)
        selectedTimeSignature = TimeSignature(beats: currentTimeSignature.beats, noteLength: noteLength)
    }


    func commit() {
        metronome.configuration.setTimeSignature(selectedTimeSignature)
    }
}
