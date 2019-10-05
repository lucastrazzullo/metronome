//
//  TimeSignatureTests.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 5/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import XCTest
@testable import Metronome

class TimeSignatureTests: XCTestCase {

    func testZeroBitsInstantiation() {
        let timeSignature = TimeSignature(bits: 0, noteLength: .quarter)
        XCTAssertEqual(1, timeSignature.bits)
    }


    func testNegativeBitsInstantiation() {
        let timeSignature = TimeSignature(bits: -1, noteLength: .quarter)
        XCTAssertEqual(1, timeSignature.bits)
    }
}
