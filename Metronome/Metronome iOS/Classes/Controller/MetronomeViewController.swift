//
//  MetronomeViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

class MetronomeViewController: UIHostingController<MetronomeView> {

    private var metronomePublisher: SnapshotMetronomePublisher<MetronomeViewModel>


    // MARK: Object life cycle

    init(with metronomeDispatcher: MetronomeDispatcher, metronome: Metronome) {
        self.metronomePublisher = SnapshotMetronomePublisher<MetronomeViewModel>(metronome: metronome)
        super.init(rootView: MetronomeView(publisher: metronomePublisher))

        metronomeDispatcher.addObserver(metronomePublisher)
        metronomeDispatcher.addObserver(self)
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MetronomeViewController: MetronomeObserver {

    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
    }


    func metronome(_ metronome: Metronome, didTick iteration: Int) {
    }


    func metronome(_ metronome: Metronome, didStartAt iteration: Int) {
        UIApplication.shared.isIdleTimerDisabled = true
    }


    func metronome(_ metronome: Metronome, didResetAt iteration: Int) {
        UIApplication.shared.isIdleTimerDisabled = false
    }
}
