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
    @Published var confirmationEnabled: Bool

    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    init(metronome: Metronome) {
        tempoPickerViewModel = TempoPickerViewModel(metronome: metronome)
        timeSignaturePickerViewModel = TimeSignaturePickerViewModel(metronome: metronome)
        confirmationEnabled = false

        cancellables.append($tempoPickerViewModel.sink { [weak self, weak metronome] viewModel in
            self?.confirmationEnabled = viewModel.selectedTempoItem.bpm != metronome?.configuration.tempo.bpm
        })
        cancellables.append($timeSignaturePickerViewModel.sink { [weak self, weak metronome] viewModel in
            self?.confirmationEnabled =
                viewModel.selectedBarLength != metronome?.configuration.timeSignature.beats ||
                viewModel.selectedNoteLength != metronome?.configuration.timeSignature.noteLength.rawValue
        })
    }


    // MARK: Public methods

    func commit() {
        tempoPickerViewModel.commit()
        timeSignaturePickerViewModel.commit()
    }
}
