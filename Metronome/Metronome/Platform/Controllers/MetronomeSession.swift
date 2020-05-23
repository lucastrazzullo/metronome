//
//  MetronomeSession.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 18/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Combine

struct Snapshot {
    var configuration: MetronomeConfiguration
    var isSoundOn: Bool
    var isRunning: Bool
    var currentBeat: Beat?
}


protocol MetronomeSession: AnyObject {
    var configuration: MetronomeConfiguration { get set }
    var isSoundOn: Bool { get set }
    var isRunning: Bool { get set }
    var currentBeat: Beat? { get set }

    func configurationPublisher() -> AnyPublisher<MetronomeConfiguration, Never>
    func isSoundOnPublisher() -> AnyPublisher<Bool, Never>
    func isRunningPublisher() -> AnyPublisher<Bool, Never>
    func currentBeatPublisher() -> AnyPublisher<Beat?, Never>
}


extension MetronomeSession {

    func currentSnapshot() -> Snapshot {
        Snapshot(configuration: configuration, isSoundOn: isSoundOn, isRunning: isRunning, currentBeat: currentBeat)
    }


    func snapshotPublisher() -> AnyPublisher<Snapshot, Never> {
        return Publishers.CombineLatest4(
            configurationPublisher(),
            isSoundOnPublisher(),
            isRunningPublisher(),
            currentBeatPublisher())
            .map(Snapshot.init)
            .eraseToAnyPublisher()
    }
}
