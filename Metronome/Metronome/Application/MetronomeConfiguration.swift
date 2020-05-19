//
//  MetronomeConfiguration.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct MetronomeConfiguration: Equatable {

    var timeSignature: TimeSignature
    var tempo: Tempo


    // MARK: Object life cycle

    static var `default`: MetronomeConfiguration {
        return MetronomeConfiguration(timeSignature: .default, tempo: .default)
    }


    // MARK: Public methods

    func getTimeInterval() -> TimeInterval {
        return Double(60) / Double(tempo.bpm) / (Double(timeSignature.noteLength.rawValue) / Double(4))
    }


    func getBpm(with frequency: TimeInterval) -> Int {
        let standardNoteBpm = 60 / frequency
        let bpm = Int(standardNoteBpm) * 4 / timeSignature.noteLength.rawValue
        return max(Tempo.range.lowerBound, min(Tempo.range.upperBound, bpm))
    }


    mutating func setBpm(_ bpm: Int) {
        tempo = Tempo(bpm: bpm)
    }


    mutating func setAccent(_ isAccent: Bool, onBeatWith position: Int) {
        if position < timeSignature.barLength.numberOfBeats {
            timeSignature.barLength.beats[position].isAccent = isAccent
        }
    }


    mutating func setTimeSignature(_ signature: TimeSignature) {
        timeSignature = signature
    }
}
