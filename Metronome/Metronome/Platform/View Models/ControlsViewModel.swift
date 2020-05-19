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
    @Published var tapTempoIndicatorIsHighlighted: Bool
    @Published var timeSignatureLabel: String
    @Published var metronomeTogglerLabel: String
    @Published var soundTogglerIcon: SystemIcon

    @Published var metronomeIsRunning: Bool
    @Published var metronomeSoundIsOn: Bool

    let metronome: Metronome

    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    init(with metronomePublisher: MetronomePublisher) {
        metronome = metronomePublisher.metronome

        let timeSignature = metronome.configuration.timeSignature
        timeSignatureLabel = String(format: Copy.TimeSignature.format.localised, timeSignature.barLength.numberOfBeats, timeSignature.noteLength.rawValue)
        tempoLabel = Copy.Tempo.unit.localised.uppercased()

        tapTempoLabel = Copy.Controls.tapTempo.localised
        tapTempoIndicatorIsHighlighted = false

        metronomeTogglerLabel = Copy.Controls.start.localised
        soundTogglerIcon = SystemIcon.soundOff

        metronomeIsRunning = metronome.isRunning
        metronomeSoundIsOn = metronome.isSoundOn

        cancellables.append(metronomePublisher.$configuration.sink { [weak self] configuration in
            let timeSignature = configuration.timeSignature
            self?.timeSignatureLabel = String(format: Copy.TimeSignature.format.localised, timeSignature.barLength.numberOfBeats, timeSignature.noteLength.rawValue)
            self?.tempoLabel = "\(configuration.tempo.bpm)\(Copy.Tempo.unit.localised.uppercased())"
        })

        cancellables.append(metronomePublisher.$isSoundOn.sink { [weak self] isSoundOn in
            self?.soundTogglerIcon = isSoundOn ? SystemIcon.soundOn : SystemIcon.soundOff
            self?.metronomeSoundIsOn = isSoundOn
        })

        cancellables.append(metronomePublisher.$isRunning.sink { [weak self] isRunning in
            self?.metronomeIsRunning = isRunning
            self?.metronomeTogglerLabel = isRunning ? Copy.Controls.stop.localised : Copy.Controls.start.localised
            self?.tapTempoIndicatorIsHighlighted = isRunning
        })

        cancellables.append(Publishers.CombineLatest(metronomePublisher.$currentBeat, metronomePublisher.$isRunning).sink {
            [weak self] _, isRunning in
            if isRunning {
                self?.tapTempoIndicatorIsHighlighted.toggle()
            } else {
                self?.tapTempoIndicatorIsHighlighted = false
            }
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
