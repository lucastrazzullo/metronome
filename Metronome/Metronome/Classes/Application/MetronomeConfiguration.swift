//
//  MetronomeConfiguration.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct MetronomeConfiguration {
    let timeSignature: TimeSignature
    var tempo: Tempo
}


extension MetronomeConfiguration {

    func getTimeInterval() -> TimeInterval {
        return Double(60) / Double(tempo.bpm) / (Double(timeSignature.noteLength) / Double(4))
    }


    func barLength() -> Int {
        return timeSignature.bits
    }
}
