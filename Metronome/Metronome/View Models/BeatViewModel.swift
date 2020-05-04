//
//  BeatViewModel.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

struct BeatViewModel: Hashable {

    let label: String
    let isHighlighted: Bool
    let isHenhanced: Bool

    init(with beat: Beat, isHighlighted: Bool, isHenhanced: Bool) {
        self.label = String(beat.position)
        self.isHighlighted = isHighlighted
        self.isHenhanced = isHenhanced
    }
}
