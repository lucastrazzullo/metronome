//
//  DefaultMetronomeSession.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 23/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Combine

class DefaultMetronomeSession: MetronomeSession {

    @Published var configuration: MetronomeConfiguration
    @Published var isSoundOn: Bool
    @Published var isRunning: Bool
    @Published var currentBeat: Beat?

    private var metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.configuration = metronome.configuration
        self.isSoundOn = metronome.isSoundOn
        self.isRunning = metronome.isRunning
        self.currentBeat = metronome.currentBeat
        self.metronome = metronome
        self.metronome.delegate = self
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


extension DefaultMetronomeSession: MetronomeDelegate {

    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
        self.configuration = configuration
    }


    func metronome(_ metronome: Metronome, didUpdate isSoundOn: Bool) {
        self.isSoundOn = isSoundOn
    }


    func metronome(_ metronome: Metronome, didPulse beat: Beat) {
        self.currentBeat = beat
    }


    func metronome(_ metronome: Metronome, willStartWithSuspended beat: Beat?) {
        self.isRunning = true
        self.currentBeat = beat
    }


    func metronome(_ metronome: Metronome, willResetAt beat: Beat?) {
        self.isRunning = false
        self.currentBeat = beat
    }
}
