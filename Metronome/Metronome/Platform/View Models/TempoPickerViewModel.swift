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

    @Published var selectedTempoBpm: Double = 0

    let controller: SessionController

    private(set) var tempoItems: [Int] = Array(Tempo.range)
    private(set) var tempoRange: ClosedRange<Int> = Tempo.range

    private var cancellables: Set<AnyCancellable> = []


    // MARK: Object life cycle

    init(controller: SessionController) {
        self.controller = controller
        self.controller.sessionPublisher
            .sink(receiveValue: setupWith(session:))
            .store(in: &cancellables)
    }


    //  MARK: Setup

    private func setupWith(session: MetronomeSession) {
        session.$configuration
            .sink(receiveValue: { [weak self] in self?.selectedTempoBpm = Double($0.tempo.bpm) })
            .store(in: &cancellables)
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
