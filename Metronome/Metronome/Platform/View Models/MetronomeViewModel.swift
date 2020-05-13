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
}