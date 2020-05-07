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
        TipViewModel(title: Copy.Tips.toggleTitle.localised, description: Copy.Tips.toggleDescription.localised, illustration: "Tap"),
        TipViewModel(title: Copy.Tips.longPressTitle.localised, description: Copy.Tips.longPressDescription.localised, illustration: "LongPress"),
        TipViewModel(title: Copy.Tips.verticalSlideTitle.localised, description: Copy.Tips.verticalSlideDescription.localised, illustration: "DoubleFingerVerticalSlide"),
        TipViewModel(title: Copy.Tips.horizontalSlideTitle.localised, description: Copy.Tips.horizontalSlideDescription.localised, illustration: "DoubleFingerHorizontalSlide"),
        TipViewModel(title: Copy.Tips.pinchTitle.localised, description: Copy.Tips.pinchDescription.localised, illustration: "Pinch")
    ]
}
