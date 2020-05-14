//
//  NoteLengthPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 14/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class NoteLengthPickerViewModel: ObservableObject {

    @Published private(set) var selectedTimeSignature: TimeSignature

    private let metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome
        self.selectedTimeSignature = metronome.configuration.timeSignature
    }


    // MARK: Public methods

    func update(with offset: Int) {
        let currentTimeSignature = metronome.configuration.timeSignature
        let noteLength = currentTimeSignature.noteLength.with(offset: offset)
        selectedTimeSignature = TimeSignature(barLength: currentTimeSignature.barLength, noteLength: noteLength)
    }


    func commit() {
        metronome.configuration.setTimeSignature(selectedTimeSignature)
    }
}
