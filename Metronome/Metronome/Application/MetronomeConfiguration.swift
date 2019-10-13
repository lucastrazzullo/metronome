//
//  MetronomeConfiguration.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct MetronomeConfiguration {
    var timeSignature: TimeSignature
    var tempo: Tempo
}


extension MetronomeConfiguration {

    func getTimeInterval() -> TimeInterval {
        return Double(60) / Double(tempo.bpm) / (Double(timeSignature.noteLength.rawValue) / Double(4))
    }


    mutating func updateTempoWithFrequency(_ frequency: TimeInterval) {
        let standardNoteBpm = 60 / frequency
        let bpm = Int(standardNoteBpm) * 4 / timeSignature.noteLength.rawValue
        tempo = Tempo(bpm: bpm)
    }
}
