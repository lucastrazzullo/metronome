//
//  NoteLengthPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 14/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class NoteLengthPickerViewModel: GesturePickerViewModel {

    private(set) var selectedTimeSignature: TimeSignature
    private let initialTimeSignature: TimeSignature


    // MARK: Object life cycle

    init(timeSignature: TimeSignature) {
        selectedTimeSignature = timeSignature
        initialTimeSignature = timeSignature

        let value = String(timeSignature.noteLength.rawValue)
        let background = Palette.purple
        let title = Copy.TimeSignature.noteLength.localised
        let prefix = String(format: Copy.TimeSignature.noteLengthPrefixFormat.localised, timeSignature.beats)
        super.init(value: value, background: background, title: title, prefix: prefix, suffix: nil)
    }


    // MARK: Public methods

    func apply(noteLength offset: Int) {
        let noteLength = initialTimeSignature.noteLength.with(offset: offset)
        selectedTimeSignature = TimeSignature(beats: initialTimeSignature.beats, noteLength: noteLength)
        heroLabel = String(noteLength.rawValue)
    }
}
