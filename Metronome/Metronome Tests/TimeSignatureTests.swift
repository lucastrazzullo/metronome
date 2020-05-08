//
//  TimeSignatureTests.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 5/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import XCTest

class TimeSignatureTests: XCTestCase {

    func testZeroBeatsInstantiation() {
        let timeSignature = TimeSignature(numberOfBeats: 0, noteLength: .quarter)
        XCTAssertEqual(TimeSignature.barLengthRange.lowerBound, timeSignature.beats.count)
    }


    func testNegativeBeatsInstantiation() {
        let timeSignature = TimeSignature(numberOfBeats: -1, noteLength: .quarter)
        XCTAssertEqual(TimeSignature.barLengthRange.lowerBound, timeSignature.beats.count)
    }
}
