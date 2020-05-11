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

    private var cancellable: AnyCancellable?


    // MARK: Object life cycle

    init(for beat: Beat, metronomePublisher: MetronomePublisher) {
        cancellable = metronomePublisher.snapshotPublisher().sink { [weak self] snapshot in
            self?.update(with: beat, snapshot: snapshot)
        }
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
        temporaryIsAccent = nil
    }


    // MARK: Private helper static methods

    private func update(with beat: Beat, snapshot: MetronomePublisher.Snapshot) {
        label = String(beat.position + 1)
        isHighlighted = snapshot.isRunning && snapshot.currentBeat == beat
        isAccent = beat.intensity == .strong
    }
}
