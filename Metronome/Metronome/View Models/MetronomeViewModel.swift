//
//  MetronomeViewModel.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class MetronomeViewModel {

    private(set) var beatsViewModel: BeatsViewModel
    private(set) var controlsViewModel: ControlsViewModel


    // MARK: Object life cycle

    init(metronomePublisher: MetronomePublisher) {
        beatsViewModel = BeatsViewModel(metronomePublisher: metronomePublisher)
        controlsViewModel = ControlsViewModel(with: metronomePublisher)
    }


    // MARK: Public methods

//    func set(timeSignature: TimeSignature) {
//        metronome.configuration.setTimeSignature(timeSignature)
//    }
//
//
//    func set(tempo: Tempo) {
//        metronome.configuration.setBpm(tempo.bpm)
//    }
//
//
//    func set(configuration: MetronomeConfiguration) {
//        metronome.configuration = configuration
//    }
}
