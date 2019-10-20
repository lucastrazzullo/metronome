//
//  MetronomeViewController.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import WatchKit
import SwiftUI
import Combine

class MetronomeViewController: WKHostingController<MetronomeView> {

    private let metronome: Metronome
    private let metronomeDispatcher: MetronomeDispatcher
    private let metronomePublisher: SnapshotMetronomePublisher<MetronomeViewModel>

    private let rootView: MetronomeView


    // MARK: Object life cycle

    override init() {
        let configuration = MetronomeConfiguration(timeSignature: TimeSignature.default, tempo: Tempo.default)
        metronome = Metronome(with: configuration)
        metronomePublisher = SnapshotMetronomePublisher<MetronomeViewModel>(metronome: metronome)
        metronomeDispatcher = MetronomeDispatcher(with: metronome)
        rootView = MetronomeView(publisher: metronomePublisher)
        super.init()
    }


    // MARK: Interface life cycle

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        metronomeDispatcher.addObserver(metronomePublisher)
        metronomeDispatcher.addObserver(self)
    }


    override func didDeactivate() {
        metronome.reset()
        super.didDeactivate()
    }


    // MARK: View

    override var body: MetronomeView {
        return rootView
    }
}


extension MetronomeViewController: MetronomeObserver {

    func metronome(_ metronome: Metronome, didPulse beat: Beat) {
        switch beat.intensity {
        case .normal:
            WKInterfaceDevice.current().play(WKHapticType.click)
        case .strong:
            WKInterfaceDevice.current().play(WKHapticType.start)
        }

    }


    func metronome(_ metronome: Metronome, willStartWithSuspended beat: Beat?) {
        WKInterfaceDevice.current().play(WKHapticType.click)
        WKExtension.shared().isAutorotating = true
    }


    func metronome(_ metronome: Metronome, willResetDuring beat: Beat?) {
        WKInterfaceDevice.current().play(WKHapticType.stop)
        WKExtension.shared().isAutorotating = false
    }


    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
    }
}
