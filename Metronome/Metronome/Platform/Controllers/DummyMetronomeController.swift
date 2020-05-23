//
//  DummyMetronomeController.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 22/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

class DummyMetronomeController: MetronomeController {

    private(set) var session: MetronomeSession = MetronomeSession(metronome: Metronome(with: .default, soundOn: false))


    // MARK: Public methods
    
    func reset() {
    }

    
    func toggleIsRunning() {
    }


    func toggleIsSoundOn() {
    }


    func set(configuration: MetronomeConfiguration) {
    }


    func set(timeSignature: TimeSignature) {
    }


    func set(tempo: Tempo) {
    }


    func set(isAccent: Bool, forBeatAt position: Int) {
    }


    func set(tempoBpm: Int) {
    }
}
