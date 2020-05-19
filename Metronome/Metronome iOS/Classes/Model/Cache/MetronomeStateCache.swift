//
//  MetronomeStateCache.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 21/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class MetronomeStateCache: Cache {

    enum Key: String {
        case barLength = "barLength"
        case noteLength = "noteLength"
        case accents = "accents"
        case bpm = "bpm"
        case soundOn = "soundOn"
    }


    // MARK: Instance properties

    var barLength: TimeSignature.BarLength? {
        get {
            guard
                let numberOfBeats = entry.value(for: Key.barLength.rawValue) as? Int,
                let accentPositions = entry.value(for: Key.accents.rawValue) as? [Int]
                else { return nil }

            return TimeSignature.BarLength(numberOfBeats: numberOfBeats, accentPositions: Set(accentPositions))
        }
        set {
            if let newValue = newValue {
                let accentPositions = Array(newValue.accentPositions)
                let numberOfBeats = newValue.numberOfBeats
                entry.set(value: numberOfBeats, for: Key.barLength.rawValue)
                entry.set(value: accentPositions, for: Key.accents.rawValue)
            } else {
                entry.set(value: nil, for: Key.barLength.rawValue)
                entry.set(value: nil, for: Key.accents.rawValue)
            }
        }
    }

    var noteLength: TimeSignature.NoteLength? {
        get {
            guard let noteLengthValue = entry.value(for: Key.noteLength.rawValue) as? Int else { return nil }
            return TimeSignature.NoteLength(rawValue: noteLengthValue)
        }
        set {
            let noteLengthValue = newValue?.rawValue
            entry.set(value: noteLengthValue, for: Key.noteLength.rawValue)
        }
    }

    var bpm: Int? {
        get {
            return entry.value(for: Key.bpm.rawValue) as? Int
        }
        set {
            entry.set(value: newValue, for: Key.bpm.rawValue)
        }
    }

    var isSoundOn: Bool {
        get {
            return entry.value(for: Key.soundOn.rawValue) as? Bool ?? false
        }
        set {
            entry.set(value: newValue, for: Key.soundOn.rawValue)
        }
    }

    var configuration: MetronomeConfiguration {
        var configuration = MetronomeConfiguration.default
        if let bpm = bpm {
            configuration.tempo = Tempo(bpm: bpm)
        }
        if let barLength = barLength, let noteLength = noteLength {
            configuration.timeSignature = TimeSignature(barLength: barLength, noteLength: noteLength)
        }
        return configuration
    }
}
