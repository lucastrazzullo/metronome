//
//  TempoPickerViewModel.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 4/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class TempoPickerViewModel: ObservableObject {

    @Published var selectedTempo: Int

    private(set) var tempoItems: [Int]

    private let metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome
        self.tempoItems = Array(Tempo.range)
        self.selectedTempo = metronome.configuration.tempo.bpm
    }


    // MARK: Public methods

    func commit() {
        metronome.configuration.tempo = Tempo(bpm: selectedTempo)
    }
}
