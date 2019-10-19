//
//  MetronomeViewModel.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct MetronomeViewModel: SnapshotMetronomePublisherModel {

    var configuration: MetronomeConfiguration {
        didSet {
            beatViewModels = MetronomeViewModel.beatViewModels(with: configuration, isRunning: isRunning, currentBeat: currentBeat)
            timeSignatureLabel = MetronomeViewModel.timeSignatureLabel(with: configuration.timeSignature)
            self.tempoLabel = MetronomeViewModel.tempoLabel(with: configuration.tempo)
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
            toggleLabel = MetronomeViewModel.toggleLabel(with: isRunning)
        }
    }


    // MARK: Getters

    private(set) var beatViewModels: [BeatViewModel]
    private(set) var timeSignatureLabel: String
    private(set) var tempoLabel: String
    private(set) var toggleLabel: String


    // MARK: Object life cycle

    init(configuration: MetronomeConfiguration, isRunning: Bool, currentBeat: MetronomeBeat?) {
        self.configuration = configuration
        self.currentBeat = currentBeat
        self.isRunning = isRunning

        self.beatViewModels = MetronomeViewModel.beatViewModels(with: configuration, isRunning: isRunning, currentBeat: currentBeat)
        self.timeSignatureLabel = MetronomeViewModel.timeSignatureLabel(with: configuration.timeSignature)
        self.tempoLabel = MetronomeViewModel.tempoLabel(with: configuration.tempo)
        self.toggleLabel = MetronomeViewModel.toggleLabel(with: isRunning)
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





    // MARK: Private builder helper methods

    private static func timeSignatureLabel(with timeSignature: TimeSignature) -> String {
        return "\(timeSignature.beats)/\(timeSignature.noteLength.rawValue)"
    }


    private static func tempoLabel(with tempo: Tempo) -> String {
        return "\(tempo.bpm)BPM"
    }


    private static func toggleLabel(with isRunning: Bool) -> String {
        return isRunning ? "Reset" : "Start"
    }
}
