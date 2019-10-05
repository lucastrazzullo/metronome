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

    private var tickExpectation: XCTestExpectation?
    private var metronome: Metronome?


    // MARK: Test life cycle

    override func tearDown() {
        super.tearDown()
        metronome?.reset()
    }


    // MARK: 4/4

    func test120bpm44ts() {
        tickExpectation = expectation(description: "120-4/4")
        tickExpectation?.expectedFulfillmentCount = 4

        let configuration = MetronomeConfiguration(timeSignature: TimeSignature(bits: 4, noteLength: .quarter), tempo: Tempo(bpm: 120))
        metronome = Metronome(with: configuration)
        metronome?.tickerDelegate = self
        metronome?.start()

        wait(for: [tickExpectation!], timeout: 2.2)
    }


    func test90bpm44ts() {
        tickExpectation = expectation(description: "90-4/4")
        tickExpectation?.expectedFulfillmentCount = 3

        let configuration = MetronomeConfiguration(timeSignature: TimeSignature(bits: 4, noteLength: .quarter), tempo: Tempo(bpm: 90))
        metronome = Metronome(with: configuration)
        metronome?.tickerDelegate = self
        metronome?.start()

        wait(for: [tickExpectation!], timeout: 2)
    }


    func test60bpm44ts() {
        tickExpectation = expectation(description: "60-4/4")
        tickExpectation?.expectedFulfillmentCount = 2

        let configuration = MetronomeConfiguration(timeSignature: TimeSignature(bits: 4, noteLength: .quarter), tempo: Tempo(bpm: 60))
        metronome = Metronome(with: configuration)
        metronome?.tickerDelegate = self
        metronome?.start()

        wait(for: [tickExpectation!], timeout: 2)
    }


    // MARK: 4/8

    func test120bpm48ts() {
        tickExpectation = expectation(description: "120-4/8")
        tickExpectation?.expectedFulfillmentCount = 8

        let configuration = MetronomeConfiguration(timeSignature: TimeSignature(bits: 4, noteLength: .eigth), tempo: Tempo(bpm: 120))
        metronome = Metronome(with: configuration)
        metronome?.tickerDelegate = self
        metronome?.start()

        wait(for: [tickExpectation!], timeout: 2)
    }
}


extension MetronomeTests: MetronomeTickerDelegate {

    func metronomeTickerDidStart(_ ticker: MetronomeTicker) {
    }


    func metronomeTickerDidReset(_ ticker: MetronomeTicker) {
    }


    func metronomeTicker(_ ticker: MetronomeTicker, didTick iteration: Int) {
        tickExpectation?.fulfill()
    }
}
