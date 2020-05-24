//
//  DummyMetronomeController.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 22/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

class DummyMetronomeController: MetronomeController {

    private(set) var session: MetronomeSession = .init(withSnapshot: .default())


    // MARK: Public methods

    func start() {
    }

    
    func reset() {
    }

    
    func toggleIsRunning() {
        session.isRunning.toggle()
    }


    func toggleIsSoundOn() {
        session.isSoundOn.toggle()
    }


    func set(configuration: MetronomeConfiguration) {
        session.configuration = configuration
    }


    func set(timeSignature: TimeSignature) {
        session.configuration.timeSignature = timeSignature
    }


    func set(tempo: Tempo) {
        session.configuration.tempo = tempo
    }


    func set(isAccent: Bool, forBeatAt position: Int) {
        session.configuration.setAccent(isAccent, onBeatWith: position)
    }


    func set(tempoBpm: Int) {
        session.configuration.setBpm(tempoBpm)
    }
}
