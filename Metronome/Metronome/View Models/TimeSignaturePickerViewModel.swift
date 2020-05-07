//
//  TimeSignaturePickerViewModel.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 4/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class TimeSignaturePickerViewModel: ObservableObject {

    @Published var selectedBarLength: Int
    @Published var selectedNoteLength: Int

    private(set) var barLengthItems: [Int]
    private(set) var noteLengthItems: [Int]

    private let metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome

        self.barLengthItems = Array(TimeSignature.barLengthRange)
        self.noteLengthItems = TimeSignature.NoteLength.allCases.map({ $0.rawValue })

        self.selectedBarLength = metronome.configuration.timeSignature.beats
        self.selectedNoteLength = metronome.configuration.timeSignature.noteLength.rawValue
    }


    // MARK: Public methods

    func commit() {
        let barLength = selectedBarLength
        let noteLength = TimeSignature.NoteLength(rawValue: selectedNoteLength)
        let timeSignature = TimeSignature(beats: barLength, noteLength: noteLength ?? .default)
        metronome.configuration.setTimeSignature(timeSignature)
    }
}
