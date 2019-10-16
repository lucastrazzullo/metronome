//
//  TipsViewModelRepository.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 16/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct TipsViewModelRepository {

    static var all: [TipViewModel] = [
        TipViewModel(title: NSLocalizedString("gesture.swipeUp.title", comment: ""), description: NSLocalizedString("gesture.swipeUp.description", comment: ""), illustration: "SwipeUp"),
        TipViewModel(title: NSLocalizedString("gesture.tap.title", comment: ""), description: NSLocalizedString("gesture.tap.description", comment: ""), illustration: "Tap"),
        TipViewModel(title: NSLocalizedString("gesture.long_press.title", comment: ""), description: NSLocalizedString("gesture.long_press.description", comment: ""), illustration: "LongPress"),
        TipViewModel(title: NSLocalizedString("gesture.vertical_slide.title", comment: ""), description: NSLocalizedString("gesture.vertical_slide.description", comment: ""), illustration: "DoubleFingerVerticalSlide"),
        TipViewModel(title: NSLocalizedString("gesture.horizontal_slide.title", comment: ""), description: NSLocalizedString("gesture.horizontal_slide.description", comment: ""), illustration: "DoubleFingerHorizontalSlide"),
        TipViewModel(title: NSLocalizedString("gesture.pinch.title", comment: ""), description: NSLocalizedString("gesture.pinch.description", comment: ""), illustration: "Pinch")
    ]
}
