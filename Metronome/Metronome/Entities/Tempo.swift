//
//  Tempo.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct Tempo {

    static let minimumBpm = 1
    static let maximumBpm = 300


    // MARK: Instance properties

    let bpm: Int


    // MARK: Object life cycle

    init(bpm: Int) {
        self.bpm = min(max(Tempo.minimumBpm, bpm), Tempo.maximumBpm)
    }
}


extension Tempo {

    static var `default`: Tempo {
        return Tempo(bpm: 120)
    }
}