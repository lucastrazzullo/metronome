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

    static let barLengthRange = 2 ... 8


    // MARK: Instance properties

    var beats: [Beat]
    let noteLength: NoteLength


    // MARK: Object life cycle

    init(numberOfBeats: Int, noteLength: NoteLength, accentPositions: Set<Int> = [0]) {
        let numberOfBeats = min(max(TimeSignature.barLengthRange.lowerBound, numberOfBeats), TimeSignature.barLengthRange.upperBound)
        self.beats = (0..<numberOfBeats).map { position in
            return Beat(position: position, isAccent: accentPositions.contains(position))
        }
        self.noteLength = noteLength
    }


    static var `default`: TimeSignature {
        return TimeSignature(numberOfBeats: 4, noteLength: .quarter)
    }


    static var commonDefaults: [TimeSignature] {
        return [
            TimeSignature(numberOfBeats: 4, noteLength: .quarter),
            TimeSignature(numberOfBeats: 3, noteLength: .quarter),
            TimeSignature(numberOfBeats: 6, noteLength: .quarter),
            TimeSignature(numberOfBeats: 8, noteLength: .quarter)
        ]
    }
}
