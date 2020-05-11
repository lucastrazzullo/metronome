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
        case noteLength
    }


    // MARK: Public static methods

    static func userInfo(for timeSignature: TimeSignature) -> [AnyHashable: Any] {
        return [
            ActivityKey.numberOfBeats.rawValue: timeSignature.beats.count,
            ActivityKey.noteLength.rawValue: timeSignature.noteLength.rawValue
        ]
    }


    static func timeSignature(in userInfo: [AnyHashable: Any]) -> TimeSignature? {
        guard
            let numberOfBeats = userInfo[ActivityKey.numberOfBeats.rawValue] as? Int,
            let noteLengthRawValue = userInfo[ActivityKey.noteLength.rawValue] as? Int,
            let noteLength = TimeSignature.NoteLength(rawValue: noteLengthRawValue)
            else { return nil }

        return TimeSignature(numberOfBeats: numberOfBeats, noteLength: noteLength)
    }
}
