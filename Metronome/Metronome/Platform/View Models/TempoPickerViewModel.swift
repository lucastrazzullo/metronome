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

    let controller: MetronomeController

    private(set) var tempoItems: [Int]
    private(set) var tempoRange: ClosedRange<Int>


    // MARK: Object life cycle

    init(controller: MetronomeController) {
        self.controller = controller
        self.tempoItems = Array(Tempo.range)
        self.tempoRange = Tempo.range
        self.selectedTempoBpm = Double(controller.session.configuration.tempo.bpm)
    }


    // MARK: Public methods

    func commit() {
        controller.set(tempo: Tempo(bpm: Int(selectedTempoBpm)))
    }


    func decreaseTempo() {
        selectedTempoBpm = Double(max(Tempo.range.lowerBound, min(Tempo.range.upperBound, Int(selectedTempoBpm - 1))))
    }


    func increaseTempo() {
        selectedTempoBpm = Double(max(Tempo.range.lowerBound, min(Tempo.range.upperBound, Int(selectedTempoBpm + 1))))
    }
}
