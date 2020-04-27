//
//  MetronomeViewModel.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class MetronomeViewModel {

    // MARK: Getters

    var beatViewModels: [BeatViewModel]
    var timeSignatureLabel: String
    var tempoLabel: String
    var toggleLabel: String


    // MARK: Object life cycle

    init(snapshot: MetronomeStatePublisher.Snapshot) {
        beatViewModels = MetronomeViewModel.beatViewModels(with: snapshot.configuration, isRunning: snapshot.isRunning, currentBeat: snapshot.currentBeat)
        timeSignatureLabel = MetronomeViewModel.timeSignatureLabel(with: snapshot.configuration.timeSignature)
        tempoLabel = MetronomeViewModel.tempoLabel(with: snapshot.configuration.tempo)
        toggleLabel = MetronomeViewModel.toggleLabel(with: snapshot.isRunning)
    }


    func setSnapshot(_ snapshot: MetronomeStatePublisher.Snapshot) {
        beatViewModels = MetronomeViewModel.beatViewModels(with: snapshot.configuration, isRunning: snapshot.isRunning, currentBeat: snapshot.currentBeat)
        timeSignatureLabel = MetronomeViewModel.timeSignatureLabel(with: snapshot.configuration.timeSignature)
        tempoLabel = MetronomeViewModel.tempoLabel(with: snapshot.configuration.tempo)
        toggleLabel = MetronomeViewModel.toggleLabel(with: snapshot.isRunning)
    }


    // MARK: Private builder helper methods

    private static func beatViewModels(with configuration: MetronomeConfiguration, isRunning: Bool, currentBeat: Beat?) -> [BeatViewModel] {
        var result: [BeatViewModel] = []
        for index in 0..<configuration.timeSignature.beats {
            let beat = Beat.with(tickIteration: index)
            let viewModel = BeatViewModel(with: beat, isHighlighted: isRunning && currentBeat == beat)
            result.append(viewModel)
        }
        return result
    }


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
