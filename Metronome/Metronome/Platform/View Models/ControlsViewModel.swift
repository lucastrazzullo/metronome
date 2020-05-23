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

    let controller: MetronomeController

    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    init(metronomeController: MetronomeController) {
        controller = metronomeController

        let timeSignature = controller.session.configuration.timeSignature
        timeSignatureLabel = String(format: Copy.TimeSignature.format.localised, timeSignature.barLength.numberOfBeats, timeSignature.noteLength.rawValue)
        tempoLabel = Copy.Tempo.unit.localised.uppercased()

        tapTempoLabel = Copy.Controls.tapTempo.localised
        tapTempoIndicatorIsHighlighted = false

        metronomeTogglerLabel = Copy.Controls.start.localised
        soundTogglerIcon = SystemIcon.soundOff

        metronomeIsRunning = controller.session.isRunning
        metronomeSoundIsOn = controller.session.isSoundOn

        cancellables.append(controller.session.$configuration.sink { [weak self] configuration in
            let timeSignature = configuration.timeSignature
            self?.timeSignatureLabel = String(format: Copy.TimeSignature.format.localised, timeSignature.barLength.numberOfBeats, timeSignature.noteLength.rawValue)
            self?.tempoLabel = String(format: Copy.Tempo.format.localised, configuration.tempo.bpm, Copy.Tempo.unit.localised.uppercased())
        })

        cancellables.append(controller.session.$isSoundOn.sink { [weak self] isSoundOn in
            self?.soundTogglerIcon = isSoundOn ? SystemIcon.soundOn : SystemIcon.soundOff
            self?.metronomeSoundIsOn = isSoundOn
        })

        cancellables.append(controller.session.$isRunning.sink { [weak self] isRunning in
            self?.metronomeIsRunning = isRunning
            self?.metronomeTogglerLabel = isRunning ? Copy.Controls.stop.localised : Copy.Controls.start.localised
            self?.tapTempoIndicatorIsHighlighted = isRunning
        })

        cancellables.append(Publishers.CombineLatest(controller.session.$currentBeat, controller.session.$isRunning).sink {
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
        controller.reset()
    }


    func toggleIsRunning() {
        controller.toggleIsRunning()
    }


    func toggleSoundOn() {
        controller.toggleIsSoundOn()
    }
}
