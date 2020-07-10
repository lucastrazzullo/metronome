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

    @Published var selectedBarLength: Double = Double(TimeSignature.default.barLength.numberOfBeats)
    @Published var selectedNoteIndex: Double = Double(TimeSignature.NoteLength.allCases.firstIndex(of: TimeSignature.default.noteLength) ?? 0)
    @Published var selectedAccentPositions: Set<Int> = []

    var selectedNote: TimeSignature.NoteLength {
        return noteItems[Int(selectedNoteIndex)]
    }

    var isAutomaticCommitActive: Bool = false
    let beats: [Beat] = TimeSignature.BarLength.maximum.beats
    let noteItems: [TimeSignature.NoteLength] = TimeSignature.NoteLength.allCases

    private let controller: SessionController
    private var cancellables: Set<AnyCancellable> = []


    // MARK: Object life cycle

    init(controller: SessionController) {
        self.controller = controller
        self.controller.sessionPublisher
            .sink(receiveValue: setupWith(session:))
            .store(in: &cancellables)

        self.$selectedBarLength
            .combineLatest($selectedNoteIndex)
            .combineLatest($selectedAccentPositions)
            .debounce(for: 0.8, scheduler: DispatchQueue.main)
            .filter({ [weak self] _ in self?.isAutomaticCommitActive ?? false })
            .sink(receiveValue: { [weak self] _ in self?.commit() })
            .store(in: &cancellables)
    }


    //  MARK: Setup

    private func setupWith(session: MetronomeSession) {
        session.$configuration
            .map({ $0.timeSignature })
            .removeDuplicates()
            .sink { [weak self] timeSignature in
                self?.selectedBarLength = Double(timeSignature.barLength.numberOfBeats)
                self?.selectedAccentPositions = timeSignature.barLength.accentPositions
                self?.selectedNoteIndex = Double(self?.noteItems.firstIndex(of: timeSignature.noteLength) ?? 0)
            }
            .store(in: &cancellables)
    }


    // MARK: Public methods

    func commit() {
        let barLength = TimeSignature.BarLength(numberOfBeats: Int(selectedBarLength), accentPositions: selectedAccentPositions)
        let noteLength = noteItems[Int(selectedNoteIndex)]
        let timeSignature = TimeSignature(barLength: barLength, noteLength: noteLength)
        controller.set(timeSignature: timeSignature)
    }


    // MARK: Public methods - Bar Length

    func decreaseBarLength() {
        selectedBarLength = Double(max(TimeSignature.BarLength.range.lowerBound, min(TimeSignature.BarLength.range.upperBound, Int(selectedBarLength) - 1)))
        selectedAccentPositions.subtract(Int(selectedBarLength)...TimeSignature.BarLength.range.upperBound)
    }


    func increaseBarLength() {
        selectedBarLength = Double(max(TimeSignature.BarLength.range.lowerBound, min(TimeSignature.BarLength.range.upperBound, Int(selectedBarLength) + 1)))
    }


    func toggleIsAccent(at position: Int) {
        if position < Int(selectedBarLength) {
            if selectedAccentPositions.contains(position) {
                selectedAccentPositions.remove(position)
            } else {
                selectedAccentPositions.insert(position)
            }
        }
    }


    // MARK: Public methods - Note Length

    func decreaseNoteLength() {
        if Int(selectedNoteIndex) - 1 >= 0 {
            selectedNoteIndex -= 1
        }
    }


    func increaseNoteLength() {
        if Int(selectedNoteIndex) + 1 < noteItems.count {
            selectedNoteIndex += 1
        }
    }


    func selectNote(_ note: TimeSignature.NoteLength) {
        if let index = noteItems.firstIndex(of: note) {
            selectedNoteIndex = Double(index)
        }
    }
}
