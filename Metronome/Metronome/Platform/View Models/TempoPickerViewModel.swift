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

    @Published var selectedTempoBpm: Double

    private(set) var tempoItems: [Int]
    private(set) var tempoRange: ClosedRange<Int>

    private let metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome
        self.tempoItems = Array(Tempo.range)
        self.tempoRange = Tempo.range
        self.selectedTempoBpm = Double(metronome.configuration.tempo.bpm)
    }


    // MARK: Public methods

    func commit() {
        metronome.configuration.tempo = Tempo(bpm: Int(selectedTempoBpm))
    }


    func decreaseTempo() {
        selectedTempoBpm = Double(max(Tempo.range.lowerBound, min(Tempo.range.upperBound, Int(selectedTempoBpm - 1))))
    }


    func increaseTempo() {
        selectedTempoBpm = Double(max(Tempo.range.lowerBound, min(Tempo.range.upperBound, Int(selectedTempoBpm + 1))))
    }
}
