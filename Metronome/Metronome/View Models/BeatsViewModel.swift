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
            if configuration.timeSignature.beats.count != self?.beats.count {
                self?.updateBeats(with: configuration)
            }
        }
    }


    // MARK: Private helper static methods

    private func updateBeats(with configuration: MetronomeConfiguration) {
        beats = configuration.timeSignature.beats.map { beat in
            return BeatViewModel(for: beat, metronomePublisher: publisher)
        }
    }
}
