//
//  Tempo.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct Tempo {

    let bpm: Int


    // MARK: Object life cycle

    init?(bpm: Int?) {
        guard let bpm = bpm, bpm > 0 else { return nil }
        self.bpm = bpm
    }
}


extension Tempo {

    static var `default`: Tempo {
        return Tempo(bpm: 120)!
    }
}
