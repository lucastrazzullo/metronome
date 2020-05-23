//
//  DefaultMetronomeController.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 22/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

class DefaultMetronomeController: MetronomeController {

    private(set) var session: MetronomeSession

    private let metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.session = MetronomeSession(with: .with(metronome: metronome))
        self.metronome = metronome
        self.metronome.delegate = self
    }
    
    
    // MARK: Public methods

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
}


extension DefaultMetronomeController: MetronomeDelegate {

    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
        self.session.configuration = configuration
    }


    func metronome(_ metronome: Metronome, didUpdate isSoundOn: Bool) {
        self.session.isSoundOn = isSoundOn
    }


    func metronome(_ metronome: Metronome, didPulse beat: Beat) {
        self.session.currentBeat = beat
    }


    func metronome(_ metronome: Metronome, willStartWithSuspended beat: Beat?) {
        self.session.isRunning = true
        self.session.currentBeat = beat
    }


    func metronome(_ metronome: Metronome, willResetAt beat: Beat?) {
        self.session.isRunning = false
        self.session.currentBeat = beat
    }
}
