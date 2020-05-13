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

    @Published var tempoLabel: String
    @Published var tapTempoLabel: String
    @Published var timeSignatureLabel: String
    @Published var metronomeTogglerLabel: String
    @Published var soundTogglerIcon: SystemIcon

    let metronome: Metronome

    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    init(with metronomePublisher: MetronomePublisher) {
        metronome = metronomePublisher.metronome

        timeSignatureLabel = String(format: Copy.TimeSignature.format.localised, Copy.Controls.placeholderValue.localised, Copy.Controls.placeholderValue.localised)
        tempoLabel = Copy.Tempo.unit.localised.uppercased()
        tapTempoLabel = Copy.Controls.tapTempo.localised

        metronomeTogglerLabel = Copy.Controls.start.localised
        soundTogglerIcon = SystemIcon.soundOff

        cancellables.append(Publishers.CombineLatest(metronomePublisher.$configuration, metronomePublisher.$isSoundOn).sink {
            [weak self] configuration, isSoundOn in
            let timeSignature = configuration.timeSignature
            self?.timeSignatureLabel = String(format: Copy.TimeSignature.format.localised, timeSignature.beats.count, timeSignature.noteLength.rawValue)
            self?.tempoLabel = "\(configuration.tempo.bpm)\(Copy.Tempo.unit.localised.uppercased())"
            self?.soundTogglerIcon = isSoundOn ? SystemIcon.soundOn : SystemIcon.soundOff
        })

        cancellables.append(metronomePublisher.$isRunning.sink { [weak self] isRunning in
            self?.metronomeTogglerLabel = isRunning ? Copy.Controls.reset.localised : Copy.Controls.start.localised
        })
    }


    // MARK: Public methods

    func reset() {
        metronome.reset()
    }


    func toggleIsRunning() {
        metronome.toggle()
    }


    func toggleSoundOn() {
        metronome.isSoundOn.toggle()
    }
}
