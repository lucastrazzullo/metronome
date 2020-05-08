//
//  SlideTempoPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class SlideTempoPickerViewModel: ObservableObject {

    @Published private(set) var selectedTempoBpm: Int

    private let metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome
        self.selectedTempoBpm = metronome.configuration.tempo.bpm
    }


    // MARK: Public methods

    func startSelection() {
        metronome.reset()
    }


    func selectTemporary(tempo offset: Int) {
        let currentBpm = metronome.configuration.tempo.bpm
        let bpm = min(Tempo.range.upperBound, max(Tempo.range.lowerBound, currentBpm + offset))
        selectedTempoBpm = bpm
    }


    func commit() {
        metronome.configuration.setBpm(selectedTempoBpm)
    }
}
