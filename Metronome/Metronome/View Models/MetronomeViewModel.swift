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
    @Published private(set) var controlsViewModel: ControlsViewModel = ControlsViewModel(with: .default, isRunning: false)

    var timeSignature: TimeSignature {
        return metronome.configuration.timeSignature
    }

    var tempo: Tempo {
        return metronome.configuration.tempo
    }

    private var metronome: Metronome
    private var cancellable: AnyCancellable?


    // MARK: Object life cycle

    init(metronomePublisher: MetronomePublisher) {
        metronome = metronomePublisher.metronome
        update(with: metronomePublisher.snapshot())
        cancellable = metronomePublisher.snapshotPublisher().sink(receiveValue: update(with:))
    }


    func toggleIsRunning() {
        metronome.toggle()
    }


    func set(timeSignature: TimeSignature) {
        metronome.configuration.setTimeSignature(timeSignature)
    }


    func set(tempo: Tempo) {
        metronome.configuration.setBpm(tempo.bpm)
    }


    // MARK: Private helper methods

    private func update(with snapshot: MetronomePublisher.Snapshot) {
        beatViewModels = beatViewModels(with: snapshot.configuration, isRunning: snapshot.isRunning, currentBeat: snapshot.currentBeat)
        controlsViewModel = ControlsViewModel(with: snapshot.configuration, isRunning: snapshot.isRunning)
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
