//
//  MetronomeViewModel.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct MetronomeViewModel {

    private(set) var beatViewModels: [BeatViewModel]
    private(set) var chromeViewModel: ChromeViewModel


    // MARK: Object life cycle

    init(snapshot: MetronomeStatePublisher.Snapshot) {
        beatViewModels = MetronomeViewModel.beatViewModels(with: snapshot.configuration, isRunning: snapshot.isRunning, currentBeat: snapshot.currentBeat)
        chromeViewModel = ChromeViewModel(configuration: snapshot.configuration)
    }


    // MARK: Private builder helper methods

    private static func beatViewModels(with configuration: MetronomeConfiguration, isRunning: Bool, currentBeat: Beat?) -> [BeatViewModel] {
        var result: [BeatViewModel] = []
        for index in 0..<configuration.timeSignature.beats {
            let beat = Beat.with(tickIteration: index)
            let viewModel = BeatViewModel(with: beat, isHighlighted: isRunning && currentBeat == beat, isHenhanced: beat.intensity == .strong)
            result.append(viewModel)
        }
        return result
    }
}
