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

    @Published var tempoLabel: String = ""
    @Published var tapTempoLabel: String = ""
    @Published var tapTempoIndicatorIsHighlighted: Bool = false
    @Published var timeSignatureLabel: String = ""
    @Published var metronomeTogglerLabel: String = ""
    @Published var soundTogglerIcon: SystemIcon = .soundOff

    @Published var metronomeIsRunning: Bool = false
    @Published var metronomeSoundIsOn: Bool = false

    let controller: SessionController

    private var cancellables: Set<AnyCancellable> = []


    // MARK: Object life cycle

    init(sessionController: SessionController) {
        controller = sessionController

        sessionController.sessionPublisher
            .sink(receiveValue: setupWith(session:))
            .store(in: &cancellables)
    }


    //  MARK: Setup

    private func setupWith(session: MetronomeSession) {
        let timeSignature = session.configuration.timeSignature
        timeSignatureLabel = String(format: Copy.TimeSignature.format.localised, timeSignature.barLength.numberOfBeats, timeSignature.noteLength.rawValue)
        tempoLabel = Copy.Tempo.unit.localised.uppercased()

        tapTempoLabel = Copy.Controls.tapTempo.localised
        tapTempoIndicatorIsHighlighted = false

        metronomeTogglerLabel = Copy.Controls.start.localised
        soundTogglerIcon = SystemIcon.soundOff

        metronomeIsRunning = session.isRunning
        metronomeSoundIsOn = session.isSoundOn

        session.$configuration.sink { [weak self] configuration in
            let timeSignature = configuration.timeSignature
            self?.timeSignatureLabel = String(format: Copy.TimeSignature.format.localised, timeSignature.barLength.numberOfBeats, timeSignature.noteLength.rawValue)
            self?.tempoLabel = String(format: Copy.Tempo.format.localised, configuration.tempo.bpm, Copy.Tempo.unit.localised.uppercased())
        }
        .store(in: &cancellables)

        session.$isSoundOn.sink { [weak self] isSoundOn in
            self?.soundTogglerIcon = isSoundOn ? SystemIcon.soundOn : SystemIcon.soundOff
            self?.metronomeSoundIsOn = isSoundOn
        }
        .store(in: &cancellables)

        session.$isRunning.sink { [weak self] isRunning in
            self?.metronomeIsRunning = isRunning
            self?.metronomeTogglerLabel = isRunning ? Copy.Controls.stop.localised : Copy.Controls.start.localised
            self?.tapTempoIndicatorIsHighlighted = isRunning
        }
        .store(in: &cancellables)

        Publishers.CombineLatest(session.$currentBeat, session.$isRunning).sink {
            [weak self] _, isRunning in
            if isRunning {
                self?.tapTempoIndicatorIsHighlighted.toggle()
            } else {
                self?.tapTempoIndicatorIsHighlighted = false
            }
        }
        .store(in: &cancellables)
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
