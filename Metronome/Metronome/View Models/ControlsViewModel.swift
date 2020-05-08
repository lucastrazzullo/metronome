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

    @Published var timeSignatureLabel: String
    @Published var timeSignatureColor: Palette

    @Published var tempoLabel: String
    @Published var tempoColor: Palette

    @Published var tapTempoLabel: String
    @Published var tapTempoColor: Palette

    @Published var togglerLabel: String
    @Published var togglerColor: Palette

    @Published var soundTogglerIcon: SystemIcon
    @Published var soundTogglerLabel: String
    @Published var soundTogglerColor: Palette


    private let metronome: Metronome
    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    init(with metronomePublisher: MetronomePublisher) {
        metronome = metronomePublisher.metronome

        timeSignatureLabel = String(format: Copy.TimeSignature.format.localised, Copy.Controls.placeholderValue.localised, Copy.Controls.placeholderValue.localised)
        timeSignatureColor = Palette.orange

        tempoLabel = Copy.Tempo.unit.localised.uppercased()
        tempoColor = Palette.yellow

        tapTempoLabel = Copy.Controls.tapTempo.localised
        tapTempoColor = Palette.green

        togglerLabel = Copy.Controls.start.localised
        togglerColor = Palette.gray

        soundTogglerIcon = SystemIcon.soundOff
        soundTogglerLabel = Copy.Controls.soundOff.localised
        soundTogglerColor = Palette.gray

        cancellables.append(Publishers.CombineLatest(metronomePublisher.$configuration, metronomePublisher.$isSoundOn).sink {
            [weak self] configuration, isSoundOn in
            let timeSignature = configuration.timeSignature
            self?.timeSignatureLabel = String(format: Copy.TimeSignature.format.localised, timeSignature.beats, timeSignature.noteLength.rawValue)
            self?.tempoLabel = "\(configuration.tempo.bpm)\(Copy.Tempo.unit.localised.uppercased())"

            self?.soundTogglerIcon = isSoundOn ? SystemIcon.soundOn : SystemIcon.soundOff
            self?.soundTogglerLabel = "\(isSoundOn ? Copy.Controls.soundOn.localised : Copy.Controls.soundOff.localised)"
            self?.soundTogglerColor = isSoundOn ? Palette.blue : Palette.gray
        })
        cancellables.append(metronomePublisher.$isRunning.sink { [weak self] isRunning in
            self?.togglerLabel = isRunning ? Copy.Controls.reset.localised : Copy.Controls.start.localised
            self?.togglerColor = isRunning ? Palette.gray : Palette.blue
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


    func tempoPickerViewModel() -> TempoPickerViewModel {
        return TempoPickerViewModel(metronome: metronome)
    }


    func tapTempoPickerViewModel() -> TapTempoPickerViewModel {
        return TapTempoPickerViewModel(metronome: metronome)
    }


    func timeSignaturePickerViewModel() -> TimeSignaturePickerViewModel {
        return TimeSignaturePickerViewModel(metronome: metronome)
    }
}
