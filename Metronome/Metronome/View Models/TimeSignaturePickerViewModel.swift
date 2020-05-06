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

    struct Item: Hashable {

        let length: Int
        let label: String

        init(length: Int) {
            self.length = length
            self.label = String(length)
        }
    }


    // MARK: Instance properties

    @Published var selectedBarLength: Item
    @Published var selectedNoteLength: Item

    private(set) var barLengthItems: [Item]
    private(set) var noteLengthItems: [Item]

    private let metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome

        barLengthItems = TimeSignature.barLengthRange.map(Item.init)
        noteLengthItems = TimeSignature.NoteLength.allCases.map({ $0.rawValue }).map(Item.init)

        selectedBarLength = Item(length: metronome.configuration.timeSignature.beats)
        selectedNoteLength = Item(length: metronome.configuration.timeSignature.noteLength.rawValue)
    }


    // MARK: Public methods

    func commit() {
        let barLength = self.selectedBarLength.length
        let noteLength = TimeSignature.NoteLength(rawValue: selectedNoteLength.length)
        let timeSignature = TimeSignature(beats: barLength, noteLength: noteLength ?? .default)
        metronome.configuration.setTimeSignature(timeSignature)
    }
}
