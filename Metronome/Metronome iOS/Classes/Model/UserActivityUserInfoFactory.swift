//
//  UserActivityUserInfoFactory.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 11/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

class UserActivityFactory {

    enum ActivityType: String {
        case startMetronome = "com.lucastrazzullo.metronome.start-metronome"
    }


    enum ActivityKey: String {
        case numberOfBeats
        case noteLength
    }


    // MARK: Public class methods

    static func buildStartMetronomeActivity(for configuration: MetronomeConfiguration) -> NSUserActivity {
        let activityType = ActivityType.startMetronome.rawValue
        let activity = NSUserActivity(activityType: activityType)
        activity.isEligibleForSearch = true
        activity.isEligibleForHandoff = true
        activity.isEligibleForPrediction = true
        activity.isEligibleForPublicIndexing = true

        let timeSignatureFormat = Copy.TimeSignature.format.localised
        let timeSignature = String(format: timeSignatureFormat, configuration.timeSignature.beats.count, configuration.timeSignature.noteLength.rawValue)

        activity.title = "\(Copy.Controls.start.localised) \(timeSignature) \(Copy.App.title.localised)"
        activity.keywords = [Copy.App.title.localised, Copy.TimeSignature.title.localised, timeSignature]
        activity.userInfo = userInfo(for: configuration.timeSignature)

        return activity
    }


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
