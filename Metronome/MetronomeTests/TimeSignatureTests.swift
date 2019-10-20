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
        let timeSignature = TimeSignature(beats: 0, noteLength: .quarter)
        XCTAssertEqual(1, timeSignature.beats)
    }


    func testNegativeBeatsInstantiation() {
        let timeSignature = TimeSignature(beats: -1, noteLength: .quarter)
        XCTAssertEqual(1, timeSignature.beats)
    }
}
