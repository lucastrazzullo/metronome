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

    @Published var selectedBarLength: Int = 0
    @Published var selectedAccentPositions: Set<Int> = []
    @Published var selectedNoteLength: Int = 0

    let barLengthItems: [Beat] = TimeSignature.BarLength.maximum.beats
    let noteLengthItems: [TimeSignature.NoteLength] = TimeSignature.NoteLength.allCases
    let controller: SessionController

    private var cancellables: Set<AnyCancellable> = []


    // MARK: Object life cycle

    init(controller: SessionController) {
        self.controller = controller
        self.controller.sessionPublisher
            .sink(receiveValue: setupWith(session:))
            .store(in: &cancellables)
    }


    //  MARK: Setup

    private func setupWith(session: MetronomeSession) {
        selectedBarLength = session.configuration.timeSignature.barLength.numberOfBeats
        selectedAccentPositions = session.configuration.timeSignature.barLength.accentPositions
        selectedNoteLength = session.configuration.timeSignature.noteLength.rawValue
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
