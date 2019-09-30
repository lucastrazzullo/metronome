//
//  MetronomeTests.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import XCTest
@testable import Metronome

class MetronomeTests: XCTestCase {

    private var tickExpectation: XCTestExpectation!
    private var metronome: Metronome?


    // MARK: Test life cycle

    override func setUp() {
        super.setUp()
        metronome = Metronome()
        metronome?.delegate = self
    }


    override func tearDown() {
        super.tearDown()
        metronome?.reset()
    }


    // MARK: Tests

    func test120bpm() {
        tickExpectation = expectation(description: "120")
        tickExpectation.expectedFulfillmentCount = 4

        metronome?.tempo = Tempo(bpm: 120)
        metronome?.start()

        wait(for: [tickExpectation].compactMap({ $0 }), timeout: 2)
    }


    func test90bpm() {
        tickExpectation = expectation(description: "90")
        tickExpectation.expectedFulfillmentCount = 3

        metronome?.tempo = Tempo(bpm: 90)
        metronome?.start()

        wait(for: [tickExpectation].compactMap({ $0 }), timeout: 2)
    }


    func test60bpm() {
        tickExpectation = expectation(description: "60")
        tickExpectation.expectedFulfillmentCount = 2

        metronome?.tempo = Tempo(bpm: 60)
        metronome?.start()

        wait(for: [tickExpectation].compactMap({ $0 }), timeout: 2)
    }
}


extension MetronomeTests: MetronomeDelegate {

    func metronome(_ metronome: Metronome, didTick bit: Int) {
        tickExpectation.fulfill()
    }
}
