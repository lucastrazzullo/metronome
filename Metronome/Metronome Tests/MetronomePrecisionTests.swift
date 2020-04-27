//
//  MetronomePrecisionTests.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 20/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import XCTest

class MetronomePrecisionTests: XCTestCase {

    private var tickExpectation: XCTestExpectation?
    private var metronome: MetronomeController?


    // MARK: Test life cycle

    override func setUp() {
        super.setUp()
        let configuration = MetronomeConfiguration(timeSignature: TimeSignature.default, tempo: Tempo.default)
        metronome = MetronomeController(with: configuration)
        metronome?.delegate = self
    }


    override func tearDown() {
        super.tearDown()
        metronome?.reset()
    }


    // MARK: Tests

    func testOneMinute() {
        tickExpectation = expectation(description: "one-minute")
        tickExpectation?.expectedFulfillmentCount = 120

        metronome?.configuration.setBpm(120)
        metronome?.configuration.setNotLength(.quarter)
        metronome?.start()

        wait(for: [tickExpectation!], timeout: 60)
    }


    func testTenMinute() {
        tickExpectation = expectation(description: "one-minute")
        tickExpectation?.expectedFulfillmentCount = 1200

        metronome?.configuration.setBpm(1200)
        metronome?.configuration.setNotLength(.quarter)
        metronome?.start()

        wait(for: [tickExpectation!], timeout: 600)
    }
}


extension MetronomePrecisionTests: MetronomeDelegate {

    func metronome(_ metronome: MetronomeController, didUpdate configuration: MetronomeConfiguration) {
    }


    func metronome(_ metronome: MetronomeController, didPulse beat: Beat) {
        tickExpectation?.fulfill()
    }


    func metronome(_ metronome: MetronomeController, willStartWithSuspended beat: Beat?) {
    }


    func metronome(_ metronome: MetronomeController, willResetDuring beat: Beat?) {
    }
}
