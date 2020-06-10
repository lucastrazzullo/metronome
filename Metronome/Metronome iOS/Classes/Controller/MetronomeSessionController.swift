//
//  MetronomeSessionController.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 22/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class MetronomeSessionController {

    var sessionPublisher: AnyPublisher<MetronomeSession, Never> {
        return currentSessionPublisher.eraseToAnyPublisher()
    }
    var session: MetronomeSession? {
        return currentSessionPublisher.value
    }

    private let currentSessionPublisher: CurrentValueSubject<MetronomeSession, Never>
    private let metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        let session = MetronomeSession(withSnapshot: .with(metronome: metronome, owner: .phone))
        self.currentSessionPublisher = CurrentValueSubject<MetronomeSession, Never>(session)
        self.metronome = metronome
        self.metronome.delegate = self
    }
}


extension MetronomeSessionController: SessionController {

    func start() {
        metronome.start()
    }


    func reset() {
        metronome.reset()
    }


    func toggleIsRunning() {
        metronome.toggle()
    }


    func toggleIsSoundOn() {
        metronome.isSoundOn.toggle()
    }


    func set(configuration: MetronomeConfiguration) {
        metronome.configuration = configuration
    }


    func set(timeSignature: TimeSignature) {
        metronome.configuration.timeSignature = timeSignature
    }


    func set(isAccent: Bool, forBeatAt position: Int) {
        metronome.configuration.setAccent(isAccent, onBeatWith: position)
    }


    func set(tempo: Tempo) {
        metronome.configuration.tempo = tempo
    }


    func set(tempoBpm: Int) {
        metronome.configuration.setBpm(tempoBpm)
    }


    func set(snapshot: MetronomeSession.Snapshot) {
        metronome.configuration = snapshot.configuration
        metronome.isSoundOn = snapshot.isSoundOn

        if snapshot.isRunning, !metronome.isRunning {
            metronome.start()
        } else if !snapshot.isRunning, metronome.isRunning {
            metronome.reset()
        }
    }
}


extension MetronomeSessionController: MetronomeDelegate {

    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
        self.session?.set(configuration: configuration, owner: .phone)
    }


    func metronome(_ metronome: Metronome, didUpdate isSoundOn: Bool) {
        self.session?.set(isSoundOn: isSoundOn, owner: .phone)
    }


    func metronome(_ metronome: Metronome, didPulse beat: Beat) {
        self.session?.set(currentBeat: beat, owner: .phone)
    }


    func metronome(_ metronome: Metronome, willStartWithSuspended beat: Beat?) {
        self.session?.set(isRunning: true, owner: .phone)
        self.session?.set(currentBeat: beat, owner: .phone)
    }


    func metronome(_ metronome: Metronome, willResetAt beat: Beat?) {
        self.session?.set(isRunning: false, owner: .phone)
        self.session?.set(currentBeat: beat, owner: .phone)
    }
}
