//
//  UserInfoFactory.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 11/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

struct UserInfoFactory {

    enum ActivityKey: String {
        case tempoBpm
        case numberOfBeats
        case accentPositions
        case noteLength
    }


    // MARK: Public static methods

    static func userInfo(for configuration: MetronomeConfiguration) -> [AnyHashable: Any] {
        return [
            ActivityKey.numberOfBeats.rawValue: configuration.timeSignature.barLength.numberOfBeats,
            ActivityKey.accentPositions.rawValue: Array(configuration.timeSignature.barLength.accentPositions),
            ActivityKey.noteLength.rawValue: configuration.timeSignature.noteLength.rawValue,
            ActivityKey.tempoBpm.rawValue: configuration.tempo.bpm
        ]
    }


    static func configuration(in userInfo: [AnyHashable: Any]) -> MetronomeConfiguration? {
        guard
            let numberOfBeats = userInfo[ActivityKey.numberOfBeats.rawValue] as? Int,
            let noteLengthRawValue = userInfo[ActivityKey.noteLength.rawValue] as? Int,
            let tempoBpm = userInfo[ActivityKey.tempoBpm.rawValue] as? Int
            else { return nil }

        let barLength: TimeSignature.BarLength = {
            if let accentPositions = userInfo[ActivityKey.accentPositions.rawValue] as? [Int] {
                return TimeSignature.BarLength(numberOfBeats: numberOfBeats, accentPositions: Set(accentPositions))
            } else {
                return TimeSignature.BarLength(numberOfBeats: numberOfBeats)
            }
        }()
        let noteLength = TimeSignature.NoteLength(rawValue: noteLengthRawValue) ?? .default
        let timeSignature = TimeSignature(barLength: barLength, noteLength: noteLength)
        let tempo = Tempo(bpm: tempoBpm)

        return MetronomeConfiguration(timeSignature: timeSignature, tempo: tempo)
    }
}
