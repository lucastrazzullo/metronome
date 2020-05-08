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
        case bpm = "bpm"
        case soundOn = "soundOn"
    }


    // MARK: Instance properties

    var barLength: Int? {
        get {
            return entry.value(for: Key.barLength.rawValue) as? Int
        }
        set {
            entry.set(value: newValue, for: Key.barLength.rawValue)
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
        if let barLength = barLength, let noteLength = noteLength {
            configuration.timeSignature = TimeSignature(beats: barLength, noteLength: noteLength)
        }
        if let bpm = bpm {
            configuration.tempo = Tempo(bpm: bpm)
        }
        return configuration
    }
}
