//
//  WelcomeViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 16/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct WelcomeViewModel: TipsViewModel {

    var tips: [TipViewModel]


    // MARK: Getters

    var titleLabel: String {
        return NSLocalizedString("welcome.title", comment: "")
    }


    func tips(with limitCount: Int) -> [TipViewModel] {
        return Array(tips[0..<limitCount])
    }


    // MARK: Public methods

    mutating func nextTip() {
        let firstTip = tips.remove(at: 0)
        tips.append(firstTip)
    }


    mutating func prevTip() {
        if let lastTip = tips.popLast() {
            tips.insert(lastTip, at: 0)
        }
    }
}
