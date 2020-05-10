//
//  ConfigurationTests.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 10/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import XCTest

class ConfigurationTests: XCTestCase {

    func testGetBpmByFrequency() {
        let configuration = MetronomeConfiguration.default
        let frequency = TimeInterval(0.5)
        let expectedBpm = 120
        XCTAssertEqual(configuration.getBpm(with: frequency), expectedBpm)
    }


    func testGetBpmByFrequencyLowerThanMinimum() {
        let configuration = MetronomeConfiguration.default
        let frequency = TimeInterval(3)
        let expectedBpm = Tempo.range.lowerBound
        XCTAssertEqual(configuration.getBpm(with: frequency), expectedBpm)
    }


    func testGetBpmByFrequencyHigherThanMaximum() {
        let configuration = MetronomeConfiguration.default
        let frequency = TimeInterval(0.01)
        let expectedBpm = Tempo.range.upperBound
        XCTAssertEqual(configuration.getBpm(with: frequency), expectedBpm)
    }
}
