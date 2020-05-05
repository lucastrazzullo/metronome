//
//  ConfigurationPickerViewModel.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 4/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class ConfigurationPickerViewModel: ObservableObject {

    @Published var tempoPickerViewModel: TempoPickerViewModel
    @Published var timeSignaturePickerViewModel: TimeSignaturePickerViewModel

    @Published var selectedConfiguration: MetronomeConfiguration
    @Published var confirmationEnabled: Bool

    private var cancellables: [AnyCancellable] = []

    init(configuration: MetronomeConfiguration) {
        tempoPickerViewModel = TempoPickerViewModel(tempo: configuration.tempo)
        timeSignaturePickerViewModel = TimeSignaturePickerViewModel(timeSignature: configuration.timeSignature)
        selectedConfiguration = configuration
        confirmationEnabled = false

        cancellables.append(Publishers.CombineLatest($tempoPickerViewModel, $timeSignaturePickerViewModel).sink {
            [weak self] tempoViewModel, timeSignatureViewModel in
            let tempo = Tempo(bpm: tempoViewModel.selectedTempoItem.bpm)
            let timeSignature = TimeSignature(beats: timeSignatureViewModel.selectedBarLength.length, noteLength: TimeSignature.NoteLength(rawValue: timeSignatureViewModel.selectedNoteLength.length) ?? .default)
            self?.selectedConfiguration = MetronomeConfiguration(timeSignature: timeSignature, tempo: tempo)
        })

        cancellables.append($selectedConfiguration.sink { [weak self] newConfiguration in
            self?.confirmationEnabled = newConfiguration != configuration
        })
    }
}
