//
//  SlideTempoPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class SlideTempoPickerViewModel: GesturePickerViewModel {

    private(set) var selectedTempoBpm: Int
    private let initialBpm: Int


    init(bpm: Int) {
        selectedTempoBpm = bpm
        initialBpm = bpm

        let value = String(bpm)
        let background = Palette.yellow
        let title = Copy.Tempo.title.localised
        let suffix = Copy.Tempo.unit.localised
        super.init(value: value, background: background, title: title, prefix: nil, suffix: suffix)
    }


    // MARK: Public methods

    func apply(offset: Int) {
        let bpm = initialBpm + offset
        selectedTempoBpm = bpm
        heroLabel = String(bpm)
    }
}
