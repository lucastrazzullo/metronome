//
//  SnapshotMetronomePublisherModel.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 17/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

protocol SnapshotMetronomePublisherModel {
    var configuration: MetronomeConfiguration { get set }
    var isRunning: Bool { get set }
    var currentIteration: Int { get set }

    init(configuration: MetronomeConfiguration, isRunning: Bool, currentIteration: Int)
    init(from metronome: Metronome)
}


extension SnapshotMetronomePublisherModel {

    init(from metronome: Metronome) {
        let configuration = metronome.configuration
        let isRunning = metronome.isRunning
        let currentIteration = metronome.currentIteration
        self.init(configuration: configuration, isRunning: isRunning, currentIteration: currentIteration)
    }
}
