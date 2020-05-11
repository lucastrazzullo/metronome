//
//  BeatViewModel.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 6/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class BeatViewModel: ObservableObject, Identifiable {

    var isTemporaryValueSelected: Bool {
        return temporaryIsAccent != nil
    }

    @Published private(set) var label: String?
    @Published private(set) var isHighlighted: Bool = false
    @Published private(set) var isAccent: Bool = false

    private var temporaryIsAccent: Bool?
    private var cancellables: [AnyCancellable] = []

    private let position: Int
    private let metronome: Metronome


    // MARK: Object life cycle

    init(for beat: Beat, metronomePublisher: MetronomePublisher) {
        self.position = beat.position
        self.metronome = metronomePublisher.metronome

        self.cancellables.append(Publishers.CombineLatest(metronomePublisher.$isRunning, metronomePublisher.$currentBeat).sink {
            [weak self] isRunning, currentBeat in
            self?.update(for: isRunning, currentBeat: currentBeat)
        })

        self.cancellables.append(metronomePublisher.$configuration.sink {
            [weak self] configuration in
            self?.update(for: configuration.timeSignature)
        })
    }


    // MARK: Public methods

    func toggleIsAccentTemporarely() {
        isAccent.toggle()
        temporaryIsAccent = isAccent
    }


    func discard() {
        if let temporaryIsAccent = temporaryIsAccent {
            isAccent = !temporaryIsAccent
        }
        temporaryIsAccent = nil
    }


    func commit() {
        if let temporaryIsAccent = temporaryIsAccent {
            metronome.configuration.setAccent(temporaryIsAccent, onBeatWith: position)
        }
        temporaryIsAccent = nil
    }


    // MARK: Private helper static methods

    private func update(for isRunning: Bool, currentBeat: Beat?) {
        label = String(position + 1)
        isHighlighted = isRunning && currentBeat?.position == position
    }


    private func update(for timeSignature: TimeSignature) {
        if position < timeSignature.beats.count {
            isAccent = timeSignature.beats[position].isAccent
        }
    }
}
