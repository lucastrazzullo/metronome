//
//  MetronomeViewController.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import WatchKit
import SwiftUI

class MetronomeViewController: WKHostingController<MetronomeView> {

    private var metronome: Metronome
    private var rootView: MetronomeView


    // MARK: Object life cycle

    override init() {
        let configuration = MetronomeConfiguration(timeSignature: .default, tempo: .default)
        metronome = Metronome(with: configuration)
        rootView = MetronomeView(model: MetronomeViewModel(configuration: configuration))
        super.init()
    }


    // MARK: Interface life cycle

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        metronome.delegate = self
        metronome.tickerDelegate = self
    }


    override func willActivate() {
        metronome.start()
        WKExtension.shared().isAutorotating = true
        super.willActivate()
    }


    override func didDeactivate() {
        metronome.reset()
        WKExtension.shared().isAutorotating = false
        super.didDeactivate()
    }


    // MARK: View

    override var body: MetronomeView {
        return rootView
    }
}


extension MetronomeViewController: MetronomeDelegate {

    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
        rootView.model.set(tempo: configuration.tempo)
        rootView.model.set(timesignature: configuration.timeSignature)
        setNeedsBodyUpdate()
    }
}


extension MetronomeViewController: MetronomeTickerDelegate {

    func metronomeTickerDidStart(_ ticker: MetronomeTicker) {
        rootView.model.set(isRunning: true)
        setNeedsBodyUpdate()
    }


    func metronomeTickerDidReset(_ ticker: MetronomeTicker) {
        rootView.model.set(isRunning: false)
        setNeedsBodyUpdate()
    }


    func metronomeTicker(_ ticker: MetronomeTicker, didTick iteration: Int) {
        rootView.model.set(currentBit: iteration)
        setNeedsBodyUpdate()
        WKInterfaceDevice.current().play(WKHapticType.start)
    }
}
