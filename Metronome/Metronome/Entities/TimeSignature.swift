//
//  TimeSignature.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct TimeSignature {

    enum NoteLength: Int, CaseIterable, Hashable {
        case full = 1
        case half = 2
        case quarter = 4
        case eigth = 8
        case sixteenth = 16
    }

    static let minimumBarLength: Int = 1
    static let maximumBarLength: Int = 16


    // MARK: Instance properties

    let bits: Int
    let noteLength: NoteLength


    // MARK: Object life cycle

    init(bits: Int, noteLength: NoteLength) {
        self.bits = min(max(TimeSignature.minimumBarLength, bits), TimeSignature.maximumBarLength)
        self.noteLength = noteLength
    }
}


extension TimeSignature {

    static var `default`: TimeSignature {
        return TimeSignature(bits: 4, noteLength: .quarter)
    }
}
