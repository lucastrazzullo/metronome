//
//  MetronomeTicker.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

protocol MetronomeTickerDelegate: AnyObject {
    func metronomeTickerWillStart(_ ticker: MetronomeTicker)
    func metronomeTickerWillReset(_ ticker: MetronomeTicker)
    func metronomeTickerDidTick(_ ticker: MetronomeTicker)
}


protocol MetronomeTicker: AnyObject {
    var delegate: MetronomeTickerDelegate? { get set }
    var isRunning: Bool { get }

    func start(with timeInterval: TimeInterval)
    func reset()
}
