//
//  TimeSignature.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct TimeSignature: Equatable {

    enum NoteLength: Int, CaseIterable, Hashable {
        case full = 1
        case half = 2
        case quarter = 4
        case eigth = 8
        case sixteenth = 16

        static var `default`: NoteLength {
            return .quarter
        }
    }

    static let minimumBarLength = 1
    static let maximumBarLength = 16
    static let barLengthRange = minimumBarLength ... maximumBarLength


    // MARK: Instance properties

    let beats: Int
    let noteLength: NoteLength


    // MARK: Object life cycle

    init(beats: Int, noteLength: NoteLength) {
        self.beats = min(max(TimeSignature.minimumBarLength, beats), TimeSignature.maximumBarLength)
        self.noteLength = noteLength
    }


    static var `default`: TimeSignature {
        return TimeSignature(beats: 4, noteLength: .quarter)
    }
}
