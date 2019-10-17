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

    private let metronomeObserver: MetronomeObserver<MetronomeViewModel>
    private var observer: Cancellable?

    private let rootView: MetronomeView


    // MARK: Object life cycle

    override init() {
        let configuration = MetronomeConfiguration(timeSignature: TimeSignature.default, tempo: Tempo.default)
        let metronome = Metronome(with: configuration)
        metronomeObserver = MetronomeObserver<MetronomeViewModel>(with: metronome)
        rootView = MetronomeView(metronomeObserver: metronomeObserver)
        super.init()
    }


    // MARK: Interface life cycle

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        observer = metronomeObserver.$snapshot.sink { [weak self] value in
            if value?.currentIteration != self?.rootView.metronomeObserver.snapshot.currentIteration {
                WKInterfaceDevice.current().play(WKHapticType.start)
            }
        }
    }


    override func willActivate() {
        WKExtension.shared().isAutorotating = true
        super.willActivate()
    }


    override func didDeactivate() {
        metronomeObserver.metronome.reset()
        WKExtension.shared().isAutorotating = false
        super.didDeactivate()
    }


    // MARK: View

    override var body: MetronomeView {
        return rootView
    }
}
