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
    @Published var selectedAccentPositions: Set<Int>
    @Published var selectedNoteLength: Int

    let controller: MetronomeController

    private(set) var barLengthItems: [Beat]
    private(set) var noteLengthItems: [TimeSignature.NoteLength]


    // MARK: Object life cycle

    init(controller: MetronomeController) {
        self.controller = controller
        self.barLengthItems = TimeSignature.BarLength.maximum.beats
        self.noteLengthItems = TimeSignature.NoteLength.allCases
        self.selectedBarLength = controller.session.configuration.timeSignature.barLength.numberOfBeats
        self.selectedAccentPositions = controller.session.configuration.timeSignature.barLength.accentPositions
        self.selectedNoteLength = controller.session.configuration.timeSignature.noteLength.rawValue
    }


    // MARK: Public methods

    func commit() {
        let barLength = TimeSignature.BarLength(numberOfBeats: selectedBarLength, accentPositions: selectedAccentPositions)
        let noteLength = TimeSignature.NoteLength(rawValue: selectedNoteLength)
        let timeSignature = TimeSignature(barLength: barLength, noteLength: noteLength ?? .default)
        controller.set(timeSignature: timeSignature)
    }


    // MARK: Public methods - Bar Length

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


    // MARK: Public methods - Note Length

    func decreaseNoteLength() {
        if let previous = TimeSignature.NoteLength(rawValue: selectedNoteLength)?.previous() {
            selectedNoteLength = previous.rawValue
        }
    }


    func increaseNoteLength() {
        if let next = TimeSignature.NoteLength(rawValue: selectedNoteLength)?.next() {
            selectedNoteLength = next.rawValue
        }
    }


    func selectNoteLength(_ length: Int) {
        if let noteLength = TimeSignature.NoteLength(rawValue: length) {
            selectedNoteLength = noteLength.rawValue
        }
    }
}
