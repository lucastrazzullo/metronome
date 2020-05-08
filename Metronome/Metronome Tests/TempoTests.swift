//
//  TempoTests.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 5/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import XCTest

class TempoTests: XCTestCase {

    func testZeroTempoInstantiation() {
        let tempo = Tempo(bpm: 0)
        XCTAssertEqual(Tempo.range.lowerBound, tempo.bpm)
    }


    func testNegativeTempoInstantiation() {
        let tempo = Tempo(bpm: -1)
        XCTAssertEqual(Tempo.range.lowerBound, tempo.bpm)
    }
}
