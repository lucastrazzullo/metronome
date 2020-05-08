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
    private var metronome: Metronome?


    // MARK: Test life cycle

    override func setUp() {
        super.setUp()
        let configuration = MetronomeConfiguration.default
        metronome = Metronome(with: configuration, soundOn: false)
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
        metronome?.configuration.setTimeSignature(TimeSignature(numberOfBeats: 4, noteLength: .quarter))
        metronome?.start()

        wait(for: [tickExpectation!], timeout: 60)
    }


    func testTenMinute() {
        tickExpectation = expectation(description: "one-minute")
        tickExpectation?.expectedFulfillmentCount = 1200

        metronome?.configuration.setBpm(1200)
        metronome?.configuration.setTimeSignature(TimeSignature(numberOfBeats: 4, noteLength: .quarter))
        metronome?.start()

        wait(for: [tickExpectation!], timeout: 600)
    }
}


extension MetronomePrecisionTests: MetronomeDelegate {

    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
    }


    func metronome(_ metronome: Metronome, didUpdate isSoundOn: Bool) {
    }


    func metronome(_ metronome: Metronome, willStartWithSuspended beat: Beat?) {
    }


    func metronome(_ metronome: Metronome, willResetAt beat: Beat?) {
    }


    func metronome(_ metronome: Metronome, didPulse beat: Beat) {
        tickExpectation?.fulfill()
    }
}
