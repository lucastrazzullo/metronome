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
        let timeSignature = TimeSignature(numberOfBeats: 0, noteLength: .quarter)
        XCTAssertEqual(timeSignature.beats.count, TimeSignature.barLengthRange.lowerBound)
    }


    func testNegativeBeatsInitialisation() {
        let timeSignature = TimeSignature(numberOfBeats: -1, noteLength: .quarter)
        XCTAssertEqual(timeSignature.beats.count, TimeSignature.barLengthRange.lowerBound)
    }


    func testWithTooManyBeatsInitialisation() {
        let timeSignature = TimeSignature(numberOfBeats: 16, noteLength: .quarter)
        XCTAssertEqual(timeSignature.beats.count, TimeSignature.barLengthRange.upperBound)
    }


    func testWithValidBeatsInitialisation() {
        let timeSignature = TimeSignature(numberOfBeats: 5, noteLength: .quarter)
        XCTAssertEqual(timeSignature.beats.count, 5)
    }


    // MARK: Accents

    func testWithDefaultAccentInitialisation() {
        let timeSignature = TimeSignature(numberOfBeats: 4, noteLength: .quarter)
        XCTAssertEqual(timeSignature.beats[0].isAccent, true)
        XCTAssertEqual(timeSignature.beats[1].isAccent, false)
        XCTAssertEqual(timeSignature.beats[2].isAccent, false)
        XCTAssertEqual(timeSignature.beats[3].isAccent, false)
    }


    func testWithCustomAccentInitialisation() {
        let timeSignature = TimeSignature(numberOfBeats: 4, noteLength: .quarter, accentPositions: [0, 2])
        XCTAssertEqual(timeSignature.beats[0].isAccent, true)
        XCTAssertEqual(timeSignature.beats[1].isAccent, false)
        XCTAssertEqual(timeSignature.beats[2].isAccent, true)
        XCTAssertEqual(timeSignature.beats[3].isAccent, false)
    }
}
