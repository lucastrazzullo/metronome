//
//  MetronomeSession.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 18/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Combine

class MetronomeSession {

    struct Snapshot {
        var configuration: MetronomeConfiguration
        var isSoundOn: Bool
        var isRunning: Bool
        var currentBeat: Beat?

        static func with(metronome: Metronome) -> Snapshot {
            return Snapshot(configuration: metronome.configuration, isSoundOn: metronome.isSoundOn, isRunning: metronome.isRunning, currentBeat: metronome.currentBeat)
        }

        static func `default`() -> Snapshot {
            return Snapshot(configuration: .default, isSoundOn: false, isRunning: false, currentBeat: nil)
        }
    }


    // MARK: Instance properties

    @Published var configuration: MetronomeConfiguration
    @Published var isSoundOn: Bool
    @Published var isRunning: Bool
    @Published var currentBeat: Beat?


    // MARK: Object life cycle

    init(configuration: MetronomeConfiguration, isSoundOn: Bool, isRunning: Bool, currentBeat: Beat?) {
        self.configuration = configuration
        self.isSoundOn = isSoundOn
        self.isRunning = isRunning
        self.currentBeat = currentBeat
    }


    init(withSnapshot snapshot: Snapshot) {
        self.configuration = snapshot.configuration
        self.isSoundOn = snapshot.isSoundOn
        self.isRunning = snapshot.isRunning
        self.currentBeat = snapshot.currentBeat
    }


    // MARK: Public methods

    func currentSnapshot() -> Snapshot {
        Snapshot(configuration: configuration, isSoundOn: isSoundOn, isRunning: isRunning, currentBeat: currentBeat)
    }


    func snapshotPublisher() -> AnyPublisher<Snapshot, Never> {
        return Publishers.CombineLatest4($configuration, $isSoundOn, $isRunning, $currentBeat)
            .map(Snapshot.init)
            .eraseToAnyPublisher()
    }
}
