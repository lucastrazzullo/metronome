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


    // MARK: Object life cycle

    static var `default`: MetronomeConfiguration {
        return MetronomeConfiguration(timeSignature: .default, tempo: .default)
    }


    // MARK: Public methods

    func getTimeInterval() -> TimeInterval {
        return Double(60) / Double(tempo.bpm) / (Double(timeSignature.noteLength.rawValue) / Double(4))
    }


    func getBmp(with frequency: TimeInterval) -> Int {
        let standardNoteBpm = 60 / frequency
        return Int(standardNoteBpm) * 4 / timeSignature.noteLength.rawValue
    }


    mutating func setBpm(_ bpm: Int) {
        tempo = Tempo(bpm: bpm)
    }


    mutating func setBarLength(_ length: Int) {
        timeSignature = TimeSignature(beats: length, noteLength: timeSignature.noteLength)
    }


    mutating func setNotLength(_ length: TimeSignature.NoteLength) {
        timeSignature = TimeSignature(beats: timeSignature.beats, noteLength: length)
    }


    mutating func setTimeSignature(_ signature: TimeSignature) {
        timeSignature = TimeSignature(beats: signature.beats, noteLength: signature.noteLength)
    }
}
