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

    static let minimumBarLength = 1
    static let maximumBarLength = 16
    static let barLengthRange = minimumBarLength ... maximumBarLength


    // MARK: Instance properties

    let beats: [Beat]
    let noteLength: NoteLength


    // MARK: Object life cycle

    init(numberOfBeats: Int, noteLength: NoteLength) {
        let numberOfBeats = min(max(TimeSignature.minimumBarLength, numberOfBeats), TimeSignature.maximumBarLength)
        self.beats = (0..<numberOfBeats).map { Beat.with(position: $0) }
        self.noteLength = noteLength
    }


    static var `default`: TimeSignature {
        return TimeSignature(numberOfBeats: 4, noteLength: .quarter)
    }
}
