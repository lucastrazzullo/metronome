//
//  HelpViewModel.swift
//  Metronome
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct HelpViewModel: Hashable {

    let titleLabel: String = NSLocalizedString("help.title", comment: "")
    let tips: [TipViewModel] = [
        TipViewModel(title: NSLocalizedString("help.tap.title", comment: ""), description: NSLocalizedString("help.tap.description", comment: ""), illustration: "Tap"),
        TipViewModel(title: NSLocalizedString("help.vertical_slide.title", comment: ""), description: NSLocalizedString("help.vertical_slide.description", comment: ""), illustration: "DoubleFingerVerticalSlide"),
        TipViewModel(title: NSLocalizedString("help.horizontal_slide.title", comment: ""), description: NSLocalizedString("help.horizontal_slide.description", comment: ""), illustration: "DoubleFingerHorizontalSlide"),
        TipViewModel(title: NSLocalizedString("help.pinch.title", comment: ""), description: NSLocalizedString("help.pinch.description", comment: ""), illustration: "Pinch")
    ]
}
