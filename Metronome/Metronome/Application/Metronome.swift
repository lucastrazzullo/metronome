//
//  Metronome.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

protocol MetronomeDelegate: AnyObject {
    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration)
}


class Metronome {

    weak var delegate: MetronomeDelegate?
    weak var tickerDelegate: MetronomeTickerDelegate? {
        didSet {
            ticker.delegate = tickerDelegate
        }
    }

    private(set) var configuration: MetronomeConfiguration
    private var ticker: MetronomeTicker


    // MARK: Public getters

    var isRunning: Bool {
        return ticker.isRunning
    }


    var currentIteration: Int {
        return ticker.iteration
    }


    // MARK: Object life cycle

    init(with configuration: MetronomeConfiguration) {
        self.configuration = configuration
        self.ticker = MetronomeTicker()
    }


    // MARK: Public methods

    func start() {
        ticker.start(with: configuration.getTimeInterval(), loopLength: configuration.barLength())
    }


    func reset() {
        ticker.reset()
    }


    func update(with newConfiguration: MetronomeConfiguration) {
        configuration = newConfiguration
        delegate?.metronome(self, didUpdate: configuration)
        reset()
    }
}
