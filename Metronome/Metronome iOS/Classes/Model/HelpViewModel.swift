//
//  HelpViewModel.swift
//  Metronome
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct HelpViewModel: Hashable {

    let spacingBetweenTips = 40
    let numberOfVisibleTips = 4


    // MARK: Content

    private var allTips: [TipViewModel] = [
        TipViewModel(title: NSLocalizedString("help.forceTap.title", comment: ""), description: NSLocalizedString("help.forceTap.description", comment: ""), illustration: "ForceTap"),
        TipViewModel(title: NSLocalizedString("help.tap.title", comment: ""), description: NSLocalizedString("help.tap.description", comment: ""), illustration: "Tap"),
        TipViewModel(title: NSLocalizedString("help.long_press.title", comment: ""), description: NSLocalizedString("help.long_press.description", comment: ""), illustration: "LongPress"),
        TipViewModel(title: NSLocalizedString("help.vertical_slide.title", comment: ""), description: NSLocalizedString("help.vertical_slide.description", comment: ""), illustration: "DoubleFingerVerticalSlide"),
        TipViewModel(title: NSLocalizedString("help.horizontal_slide.title", comment: ""), description: NSLocalizedString("help.horizontal_slide.description", comment: ""), illustration: "DoubleFingerHorizontalSlide"),
        TipViewModel(title: NSLocalizedString("help.pinch.title", comment: ""), description: NSLocalizedString("help.pinch.description", comment: ""), illustration: "Pinch")
    ]


    // MARK: Getters

    var titleLabel: String {
        return NSLocalizedString("help.title", comment: "")
    }

    var tips: [TipViewModel] {
        return Array(allTips[0..<numberOfVisibleTips])
    }


    // MARK: Public methods

    mutating func nextTip() {
        let firstTip = allTips.remove(at: 0)
        allTips.append(firstTip)
    }
}
