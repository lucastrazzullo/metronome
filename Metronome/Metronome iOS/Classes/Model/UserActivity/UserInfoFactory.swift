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
        case numberOfBeats
        case accentPositions
        case noteLength
    }


    // MARK: Public static methods

    static func userInfo(for timeSignature: TimeSignature) -> [AnyHashable: Any] {
        return [
            ActivityKey.numberOfBeats.rawValue: timeSignature.barLength.numberOfBeats,
            ActivityKey.accentPositions.rawValue: Array(timeSignature.barLength.accentPositions),
            ActivityKey.noteLength.rawValue: timeSignature.noteLength.rawValue
        ]
    }


    static func timeSignature(in userInfo: [AnyHashable: Any]) -> TimeSignature? {
        guard
            let numberOfBeats = userInfo[ActivityKey.numberOfBeats.rawValue] as? Int,
            let noteLengthRawValue = userInfo[ActivityKey.noteLength.rawValue] as? Int
            else { return nil }

        let barLength: TimeSignature.BarLength = {
            if let accentPositions = userInfo[ActivityKey.accentPositions.rawValue] as? [Int] {
                return TimeSignature.BarLength(numberOfBeats: numberOfBeats, accentPositions: Set(accentPositions))
            } else {
                return TimeSignature.BarLength(numberOfBeats: numberOfBeats)
            }
        }()
        let noteLength = TimeSignature.NoteLength(rawValue: noteLengthRawValue) ?? .default
        return TimeSignature(barLength: barLength, noteLength: noteLength)
    }
}
