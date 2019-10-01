//
//  MetronomeViewModel.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct MetronomeViewModel {

    private var isRunning: Bool = false
    private var currentBit: Int?
    private var timeSignature: TimeSignature


    // MARK: Object life cycle

    init(currentBit: Int?, timeSignature: TimeSignature) {
        self.currentBit = currentBit
        self.timeSignature = timeSignature
    }


    // MARK: Getters

    var circles: [Int] {
        return Array(0..<timeSignature.bits)
    }


    var currentCircleIndex: Int? {
        return currentBit != nil ? currentBit! - 1 : nil
    }


    var toggleLabel: String {
        return isRunning ? "Reset" : "Play"
    }


    // MARK: Mutating methods

    mutating func set(isRunning: Bool) {
        self.isRunning = isRunning
    }


    mutating func set(currentBit: Int?) {
        self.currentBit = currentBit
    }


    mutating func set(timesignature: TimeSignature) {
        self.timeSignature = timesignature
    }
}
