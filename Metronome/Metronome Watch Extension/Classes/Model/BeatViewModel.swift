//
//  BeatViewModel.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct BeatViewModel: Hashable {

    let label: String
    let isHighlighted: Bool

    init(with beat: MetronomeBeat, isHighlighted: Bool) {
        self.label = String(beat.position)
        self.isHighlighted = isHighlighted
    }
}
