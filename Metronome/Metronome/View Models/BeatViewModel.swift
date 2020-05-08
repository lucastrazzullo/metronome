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

    @Published private(set) var label: String?
    @Published private(set) var isHighlighted: Bool = false
    @Published private(set) var isHenhanced: Bool = false

    private var cancellable: AnyCancellable?


    // MARK: Object life cycle

    init(for beat: Beat, metronomePublisher: MetronomePublisher) {
        cancellable = metronomePublisher.snapshotPublisher().sink { [weak self] snapshot in
            self?.update(with: beat, snapshot: snapshot)
        }
    }


    // MARK: Private helper static methods

    private func update(with beat: Beat, snapshot: MetronomePublisher.Snapshot) {
        label = String(beat.position + 1)
        isHighlighted = snapshot.isRunning && snapshot.currentBeat == beat
        isHenhanced = beat.intensity == .strong
    }
}
