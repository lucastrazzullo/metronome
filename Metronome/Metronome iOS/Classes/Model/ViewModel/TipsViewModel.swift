//
//  TipsViewModel.swift
//  Metronome
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class TipsViewModel: ObservableObject {

    @Published private(set) var tips: [TipViewModel]

    let titleLabel: String


    // MARK: Object life cycle

    init(tips: [TipViewModel]) {
        self.tips = tips
        self.titleLabel = Copy.Tips.title.localised
    }


    // MARK: Public methods

    func nextTip() {
        let firstTip = tips.remove(at: 0)
        tips.append(firstTip)
    }


    func prevTip() {
        if let lastTip = tips.popLast() {
            tips.insert(lastTip, at: 0)
        }
    }
}
