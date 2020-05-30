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

        func next() -> NoteLength? {
            let allCases = NoteLength.allCases
            if let index = allCases.firstIndex(of: self), index + 1 >= 0, index + 1 < allCases.count {
                return allCases[index + 1]
            } else {
                return nil
            }
        }

        func previous() -> NoteLength? {
            let allCases = NoteLength.allCases
            if let index = allCases.firstIndex(of: self), index - 1 >= 0, index - 1 < allCases.count {
                return allCases[index - 1]
            } else {
                return nil
            }
        }
    }

    struct BarLength: Equatable {

        static let range = 2 ... 8

        var beats: [Beat]

        var numberOfBeats: Int {
            return beats.count
        }

        var accentPositions: Set<Int> {
            return Set(beats.enumerated().compactMap { index, beat in beat.isAccent ? index : nil })
        }

        init(numberOfBeats: Int, accentPositions: Set<Int>? = nil) {
            let numberOfBeats = min(max(BarLength.range.lowerBound, numberOfBeats), BarLength.range.upperBound)
            let accentPositions = accentPositions ?? [0]
            self.beats = (0..<numberOfBeats).map { position in
                return Beat(position: position, isAccent: accentPositions.contains(position))
            }
        }

        static var `default`: BarLength {
            return BarLength(numberOfBeats: 4)
        }

        static var maximum: BarLength {
            return BarLength(numberOfBeats: range.upperBound)
        }
    }


    // MARK: Instance properties

    var barLength: BarLength
    let noteLength: NoteLength


    // MARK: Object life cycle

    init(barLength: BarLength, noteLength: NoteLength) {
        self.barLength = barLength
        self.noteLength = noteLength
    }


    static var `default`: TimeSignature {
        return TimeSignature(barLength: .default, noteLength: .quarter)
    }


    static var commonDefaults: [TimeSignature] {
        return [
            TimeSignature(barLength: BarLength(numberOfBeats: 4), noteLength: .quarter),
            TimeSignature(barLength: BarLength(numberOfBeats: 3), noteLength: .quarter),
            TimeSignature(barLength: BarLength(numberOfBeats: 6), noteLength: .quarter),
            TimeSignature(barLength: BarLength(numberOfBeats: 8), noteLength: .quarter)
        ]
    }
}
