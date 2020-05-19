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

    @Published private(set) var selectedBarLength: Int
    @Published private(set) var selectedAccentPositions: Set<Int>
    @Published private(set) var selectedNoteLength: Int

    private(set) var barLengthItems: [Beat]
    private(set) var noteLengthItems: [TimeSignature.NoteLength]

    private let metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome

        self.barLengthItems = TimeSignature.BarLength.maximum.beats
        self.noteLengthItems = TimeSignature.NoteLength.allCases

        let timeSignature = metronome.configuration.timeSignature
        self.selectedBarLength = timeSignature.barLength.numberOfBeats
        self.selectedAccentPositions = timeSignature.barLength.accentPositions
        self.selectedNoteLength = timeSignature.noteLength.rawValue
    }


    // MARK: Public methods

    func commit() {
        let barLength = TimeSignature.BarLength(numberOfBeats: selectedBarLength, accentPositions: selectedAccentPositions)
        let noteLength = TimeSignature.NoteLength(rawValue: selectedNoteLength)
        let timeSignature = TimeSignature(barLength: barLength, noteLength: noteLength ?? .default)
        metronome.configuration.setTimeSignature(timeSignature)
    }


    func decreaseBarLength() {
        selectedBarLength = max(TimeSignature.BarLength.range.lowerBound, min(TimeSignature.BarLength.range.upperBound, selectedBarLength - 1))
        selectedAccentPositions.subtract(selectedBarLength...TimeSignature.BarLength.range.upperBound)
    }


    func increaseBarLength() {
        selectedBarLength = max(TimeSignature.BarLength.range.lowerBound, min(TimeSignature.BarLength.range.upperBound, selectedBarLength + 1))
    }


    func toggleIsAccent(at position: Int) {
        if position >= selectedBarLength {
            selectedBarLength = position + 1
        } else {
            if selectedAccentPositions.contains(position) {
                selectedAccentPositions.remove(position)
            } else {
                selectedAccentPositions.insert(position)
            }
        }
    }


    func selectNoteLength(_ length: Int) {
        selectedNoteLength = length
    }
}
