//
//  MetronomeViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class MetronomeViewController: UIHostingController<MetronomeView>, MetronomeController {

    let metronome: Metronome


    // MARK: Object life cycle

    init(with configuration: MetronomeConfiguration) {
        metronome = Metronome(with: configuration)
        super.init(rootView: MetronomeView(model: MetronomeViewModel(timeSignature: configuration.timeSignature, tempo: configuration.tempo)))
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: View life cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        metronome.delegate = self
        metronome.tickerDelegate = self
    }


    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        metronome.reset()
        metronome.delegate = nil
        metronome.tickerDelegate = nil
    }
}


extension MetronomeViewController: MetronomeDelegate {

    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
        rootView.model.set(timesignature: configuration.timeSignature)
        rootView.model.set(tempo: configuration.tempo)
    }
}


extension MetronomeViewController: MetronomeTickerDelegate {

    func metronomeTickerDidStart(_ ticker: MetronomeTicker) {
        rootView.model.set(isRunning: true)
        rootView.model.set(currentBit: nil)
    }


    func metronomeTickerDidReset(_ ticker: MetronomeTicker) {
        rootView.model.set(isRunning: false)
        rootView.model.set(currentBit: nil)
    }


    func metronomeTicker(_ ticker: MetronomeTicker, didTick iteration: Int) {
        rootView.model.set(currentBit: iteration)
    }
}
