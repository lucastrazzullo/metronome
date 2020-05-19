//
//  UserActivityUserInfoFactory.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 11/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

struct UserActivityFactory {

    static func buildActivity(for type: ActivityType, with configuration: MetronomeConfiguration) -> NSUserActivity {
        let activityType = type.rawValue
        let activity = NSUserActivity(activityType: activityType)
        activity.isEligibleForSearch = true
        activity.isEligibleForHandoff = true
        activity.isEligibleForPrediction = true
        activity.isEligibleForPublicIndexing = true

        let timeSignatureFormat = Copy.TimeSignature.format.localised
        let timeSignature = String(format: timeSignatureFormat, configuration.timeSignature.barLength.numberOfBeats, configuration.timeSignature.noteLength.rawValue)

        activity.title = "\(Copy.Controls.start.localised) \(timeSignature) \(Copy.App.title.localised)"
        activity.keywords = [Copy.App.title.localised, Copy.TimeSignature.title.localised, timeSignature]
        activity.userInfo = try? UserInfoEncoder().encode(configuration)

        return activity
    }
}
