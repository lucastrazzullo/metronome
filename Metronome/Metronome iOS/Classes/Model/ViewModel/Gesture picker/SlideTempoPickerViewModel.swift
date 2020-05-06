//
//  SlideTempoPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class SlideTempoPickerViewModel: GesturePickerViewModel {

    private let metronome: Metronome
    private var selectedTempoBpm: Int


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome
        self.selectedTempoBpm = metronome.configuration.tempo.bpm

        let value = String(selectedTempoBpm)
        let background = Palette.yellow
        let title = Copy.Tempo.title.localised
        let suffix = Copy.Tempo.unit.localised
        super.init(value: value, background: background, title: title, prefix: nil, suffix: suffix)
    }


    // MARK: Public methods

    func startSelection() {
        metronome.reset()
    }


    func selectTemporary(tempo offset: Int) {
        let currentBpm = metronome.configuration.tempo.bpm
        let bpm = min(Tempo.maximumBpm, max(Tempo.minimumBpm, currentBpm + offset))
        selectedTempoBpm = bpm
        heroLabel = String(bpm)
    }


    func commit() {
        metronome.configuration.setBpm(selectedTempoBpm)
    }
}
