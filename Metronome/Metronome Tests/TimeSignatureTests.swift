//
//  TimeSignatureTests.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 5/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import XCTest

class TimeSignatureTests: XCTestCase {

    // MARK: Number of beats

    func testZeroBeatsInitialisation() {
        let barLength = TimeSignature.BarLength(numberOfBeats: 0)
        let timeSignature = TimeSignature(barLength: barLength, noteLength: .quarter)
        XCTAssertEqual(timeSignature.barLength.numberOfBeats, TimeSignature.BarLength.range.lowerBound)
    }


    func testNegativeBeatsInitialisation() {
        let barLength = TimeSignature.BarLength(numberOfBeats: -1)
        let timeSignature = TimeSignature(barLength: barLength, noteLength: .quarter)
        XCTAssertEqual(timeSignature.barLength.numberOfBeats, TimeSignature.BarLength.range.lowerBound)
    }


    func testWithTooManyBeatsInitialisation() {
        let barLength = TimeSignature.BarLength(numberOfBeats: 16)
        let timeSignature = TimeSignature(barLength: barLength, noteLength: .quarter)
        XCTAssertEqual(timeSignature.barLength.numberOfBeats, TimeSignature.BarLength.range.upperBound)
    }


    func testWithValidBeatsInitialisation() {
        let barLength = TimeSignature.BarLength(numberOfBeats: 5)
        let timeSignature = TimeSignature(barLength: barLength, noteLength: .quarter)
        XCTAssertEqual(timeSignature.barLength.numberOfBeats, 5)
    }


    // MARK: Accents

    func testWithDefaultAccentInitialisation() {
        let barLength = TimeSignature.BarLength(numberOfBeats: 4)
        let timeSignature = TimeSignature(barLength: barLength, noteLength: .quarter)
        XCTAssertEqual(timeSignature.barLength.beats[0].isAccent, true)
        XCTAssertEqual(timeSignature.barLength.beats[1].isAccent, false)
        XCTAssertEqual(timeSignature.barLength.beats[2].isAccent, false)
        XCTAssertEqual(timeSignature.barLength.beats[3].isAccent, false)
    }


    func testWithCustomAccentInitialisation() {
        let barLength = TimeSignature.BarLength(numberOfBeats: 4, accentPositions: [0, 2])
        let timeSignature = TimeSignature(barLength: barLength, noteLength: .quarter)
        XCTAssertEqual(timeSignature.barLength.beats[0].isAccent, true)
        XCTAssertEqual(timeSignature.barLength.beats[1].isAccent, false)
        XCTAssertEqual(timeSignature.barLength.beats[2].isAccent, true)
        XCTAssertEqual(timeSignature.barLength.beats[3].isAccent, false)
    }
}
