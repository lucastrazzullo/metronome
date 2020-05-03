//
//  MetronomeViewModel.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class MetronomeViewModel: ObservableObject {

    @Published private(set) var beatViewModels: [BeatViewModel] = []
    @Published private(set) var isMetronomeRunning: Bool = false

    private var metronome: MetronomeController
    private var cancellable: AnyCancellable?


    // MARK: Object life cycle

    init(metronomePublisher: MetronomeStatePublisher) {
        metronome = metronomePublisher.metronome
        update(with: metronomePublisher.snapshot())
        cancellable = metronomePublisher.snapshotPublisher().sink(receiveValue: update(with:))
    }


    func toggleIsRunning() {
        if isMetronomeRunning {
            metronome.reset()
        } else {
            metronome.start()
        }
    }


    // MARK: Private helper methods

    private func update(with snapshot: MetronomeStatePublisher.Snapshot) {
        beatViewModels = beatViewModels(with: snapshot.configuration, isRunning: snapshot.isRunning, currentBeat: snapshot.currentBeat)
        isMetronomeRunning = snapshot.isRunning
    }


    private func beatViewModels(with configuration: MetronomeConfiguration, isRunning: Bool, currentBeat: Beat?) -> [BeatViewModel] {
        var result: [BeatViewModel] = []
        for index in 0..<configuration.timeSignature.beats {
            let beat = Beat.with(tickIteration: index)
            let viewModel = BeatViewModel(with: beat, isHighlighted: isRunning && currentBeat == beat, isHenhanced: beat.intensity == .strong)
            result.append(viewModel)
        }
        return result
    }
}
