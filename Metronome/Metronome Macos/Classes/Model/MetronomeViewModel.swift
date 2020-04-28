//
//  MetronomeViewModel.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
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


struct BeatViewModel: Hashable {

    let label: String
    let isHighlighted: Bool
    let isHenhanced: Bool

    init(with beat: Beat, isHighlighted: Bool, isHenhanced: Bool) {
        self.label = String(beat.position)
        self.isHighlighted = isHighlighted
        self.isHenhanced = isHenhanced
    }
}


struct ChromeViewModel {

    // MARK: Getters

    private(set) var timeSignatureLabel: String
    private(set) var tempoLabel: String


    // MARK: Object life cycle

    init(configuration: MetronomeConfiguration) {
        self.timeSignatureLabel = ChromeViewModel.timeSignatureLabel(with: configuration.timeSignature)
        self.tempoLabel = ChromeViewModel.tempoLabel(with: configuration.tempo)
    }


    // MARK: Private builder helper methods

    private static func timeSignatureLabel(with timeSignature: TimeSignature) -> String {
        return String(format: NSLocalizedString("metronome.time_signature.format", comment: ""), timeSignature.beats, timeSignature.noteLength.rawValue)
    }


    private static func tempoLabel(with tempo: Tempo) -> String {
        return String(format: "%d%@", tempo.bpm, NSLocalizedString("metronome.tempo.suffix", comment: "").uppercased())
    }
}
