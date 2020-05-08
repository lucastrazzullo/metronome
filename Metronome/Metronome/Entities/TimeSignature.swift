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

        func with(offset: Int) -> NoteLength {
            let allCases = NoteLength.allCases
            if let index = allCases.firstIndex(of: self), index + offset >= 0, index + offset < allCases.count {
                return allCases[index + offset]
            } else if offset > 0 {
                return allCases[allCases.count - 1]
            } else {
                return allCases[0]
            }
        }
    }

    static let barLengthRange = 2 ... 16


    // MARK: Instance properties

    let beats: [Beat]
    let noteLength: NoteLength


    // MARK: Object life cycle

    init(numberOfBeats: Int, noteLength: NoteLength) {
        let numberOfBeats = min(max(TimeSignature.barLengthRange.lowerBound, numberOfBeats), TimeSignature.barLengthRange.upperBound)
        self.beats = (0..<numberOfBeats).map { position in
            if position == 0 {
                return Beat(intensity: .strong, position: position)
            } else {
                return Beat(intensity: .normal, position: position)
            }
        }
        self.noteLength = noteLength
    }


    static var `default`: TimeSignature {
        return TimeSignature(numberOfBeats: 4, noteLength: .quarter)
    }
}
