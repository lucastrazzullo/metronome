//
//  BeatsViewModel.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class BeatsViewModel: ObservableObject {

    @Published private(set) var beats: [BeatViewModel] = []

    private let publisher: MetronomePublisher
    private var cancellable: AnyCancellable?


    // MARK: Object life cycle

    init(metronomePublisher: MetronomePublisher) {
        publisher = metronomePublisher
        cancellable = metronomePublisher.$configuration.sink { [weak self] configuration in
            if configuration.timeSignature.beats != self?.beats.count {
                self?.updateBeats(with: configuration)
            }
        }
    }


    // MARK: Private helper static methods

    private func updateBeats(with configuration: MetronomeConfiguration) {
        beats = (0..<configuration.timeSignature.beats).map { index in
            let beat = Beat.with(position: index)
            return BeatViewModel(for: beat, metronomePublisher: publisher)
        }
    }
}
