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
}

extension Tempo {

    static var `default`: Tempo {
        return Tempo(bpm: 120)
    }
}
