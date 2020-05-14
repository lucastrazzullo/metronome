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
                self?.reloadBeats(configuration.timeSignature.beats)
            }
        }
    }


    // MARK: Private helper static methods

    private func reloadBeats(_ beats: [Beat]) {
        self.beats = beats.map { beat in
            return BeatViewModel(at: beat.position, metronomePublisher: publisher)
        }
    }
}
