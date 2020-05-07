//
//  BarLengthPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class BarLengthPickerViewModel: ObservableObject {

    @Published private(set) var selectedTimeSignature: TimeSignature

    private let metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome
        self.selectedTimeSignature = metronome.configuration.timeSignature
    }


    // MARK: Public methods

    func startSelection() {
        metronome.reset()
    }


    func selectTemporary(barLength offset: Int) {
        let currentTimeSignature = metronome.configuration.timeSignature
        let beats = max(TimeSignature.minimumBarLength, min(TimeSignature.maximumBarLength, currentTimeSignature.beats + (offset / 32)))
        selectedTimeSignature = TimeSignature(beats: beats, noteLength: currentTimeSignature.noteLength)
    }


    func commit() {
        metronome.configuration.setTimeSignature(selectedTimeSignature)
    }
}
