//
//  HelpViewModel.swift
//  Metronome
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct HelpViewModel: TipsViewModel {

    private(set) var tips: [TipViewModel]
    let titleLabel: String = NSLocalizedString("help.title", comment: "")


    // MARK: Getter methods

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
