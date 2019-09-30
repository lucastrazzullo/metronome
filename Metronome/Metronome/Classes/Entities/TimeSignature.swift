//
//  TimeSignature.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct TimeSignature {
    let bits: Int
    let noteLength: Int
}


extension TimeSignature {

    static var `default`: TimeSignature {
        return TimeSignature(bits: 4, noteLength: 4)
    }
}
