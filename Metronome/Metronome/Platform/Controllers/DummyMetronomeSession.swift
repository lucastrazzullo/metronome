//
//  DummyMetronomeSession.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 23/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Combine

class DummyMetronomeSession: MetronomeSession {

    @Published var configuration: MetronomeConfiguration
    @Published var isSoundOn: Bool
    @Published var isRunning: Bool
    @Published var currentBeat: Beat?


    // MARK: Object life cycle

    init() {
        configuration = .default
        isSoundOn = false
        isRunning = false
        currentBeat = nil
    }


    // MARK: Public methods

    func configurationPublisher() -> AnyPublisher<MetronomeConfiguration, Never> {
        return $configuration.eraseToAnyPublisher()
    }


    func isSoundOnPublisher() -> AnyPublisher<Bool, Never> {
        return $isSoundOn.eraseToAnyPublisher()
    }


    func isRunningPublisher() -> AnyPublisher<Bool, Never> {
        return $isRunning.eraseToAnyPublisher()
    }


    func currentBeatPublisher() -> AnyPublisher<Beat?, Never> {
        return $currentBeat.eraseToAnyPublisher()
    }
}
