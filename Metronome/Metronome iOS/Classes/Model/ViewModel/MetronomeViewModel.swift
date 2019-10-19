//
//  MetronomeViewModel.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct MetronomeViewModel: SnapshotMetronomePublisherModel {

    var configuration: MetronomeConfiguration {
        didSet {
            beatViewModels = MetronomeViewModel.beatViewModels(with: configuration, isRunning: isRunning, currentBeat: currentBeat)
        }
    }
    var currentBeat: MetronomeBeat? {
        didSet {
            beatViewModels = MetronomeViewModel.beatViewModels(with: configuration, isRunning: isRunning, currentBeat: currentBeat)
        }
    }
    var isRunning: Bool {
        didSet {
            beatViewModels = MetronomeViewModel.beatViewModels(with: configuration, isRunning: isRunning, currentBeat: currentBeat)
        }
    }

    private(set) var beatViewModels: [BeatViewModel]


    // MARK: Object life cycle

    init(configuration: MetronomeConfiguration, isRunning: Bool, currentBeat: MetronomeBeat?) {
        self.configuration = configuration
        self.currentBeat = currentBeat
        self.isRunning = isRunning

        self.beatViewModels = MetronomeViewModel.beatViewModels(with: configuration, isRunning: isRunning, currentBeat: currentBeat)
    }


    // MARK: Private builder helper methods

    private static func beatViewModels(with configuration: MetronomeConfiguration, isRunning: Bool, currentBeat: MetronomeBeat?) -> [BeatViewModel] {
        var result: [BeatViewModel] = []
        for index in 0..<configuration.timeSignature.beats {
            let beat = MetronomeBeat.with(tickIteration: index)
            let viewModel = BeatViewModel(with: beat, isHighlighted: isRunning && currentBeat == beat)
            result.append(viewModel)
        }
        return result
    }
}
