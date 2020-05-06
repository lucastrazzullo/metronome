//
//  ControlsViewModel.swift
//  Metronome
//
//  Created by luca strazzullo on 3/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class ControlsViewModel: ObservableObject {

    @Published var timeSignatureLabel: String?
    @Published var tempoLabel: String?
    @Published var toggleLabel: String?

    private let metronome: Metronome
    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    init(with metronomePublisher: MetronomePublisher) {
        metronome = metronomePublisher.metronome

        cancellables.append(metronomePublisher.$configuration.sink { [weak self] configuration in
            let timeSignature = configuration.timeSignature
            self?.timeSignatureLabel = String(format: Copy.TimeSignature.format.localised, timeSignature.beats, timeSignature.noteLength.rawValue)
            self?.tempoLabel = "\(configuration.tempo.bpm)\(Copy.Tempo.unit.localised.uppercased())"
        })
        cancellables.append(metronomePublisher.$isRunning.sink { [weak self] isRunning in
            self?.toggleLabel = isRunning ? Copy.Controls.reset.localised : Copy.Controls.start.localised
        })
    }


    // MARK: Public methods

    func reset() {
        metronome.reset()
    }
}
