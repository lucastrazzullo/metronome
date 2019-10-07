//
//  Playable.swift
//  Metronome
//
//  Created by luca strazzullo on 5/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

protocol MetronomeController: AnyObject {
    var metronome: Metronome { get }
}


extension MetronomeController {

    var tempo: Tempo {
        return metronome.configuration.tempo
    }


    var timeSignature: TimeSignature {
        return metronome.configuration.timeSignature
    }


    func toggle() {
        if metronome.isRunning { metronome.reset() } else { metronome.start() }
    }


    func start() {
        metronome.start()
    }


    func reset() {
        metronome.reset()
    }


    func updateTempo(_ tempo: Tempo?) {
        guard let tempo = tempo else { return }
        var configuration = metronome.configuration
        configuration.tempo = tempo
        metronome.update(with: configuration)
    }


    func updateTimeSignature(_ timeSignature: TimeSignature?) {
        guard let timeSignature = timeSignature else { return }
        var configuration = metronome.configuration
        configuration.timeSignature = timeSignature
        metronome.update(with: configuration)
    }
}
