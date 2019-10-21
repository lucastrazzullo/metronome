//
//  MetronomeViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

class MetronomeViewController: UIHostingController<MetronomeView>, ContainerViewController {

    private var metronomePublisher: SnapshotMetronomePublisher<MetronomeViewModel>
    private var gesturesController: MetronomeGesturesController


    // MARK: Object life cycle

    init(with metronomeDispatcher: MetronomeDispatcher, metronome: Metronome) {
        self.metronomePublisher = SnapshotMetronomePublisher<MetronomeViewModel>(metronome: metronome)
        self.gesturesController = MetronomeGesturesController(with: metronome)
        super.init(rootView: MetronomeView(publisher: metronomePublisher))

        metronomeDispatcher.addObserver(metronomePublisher)
        metronomeDispatcher.addObserver(self)

        gesturesController.presentingViewController = self
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MetronomeViewController: MetronomeObserver {

    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
    }


    func metronome(_ metronome: Metronome, didPulse beat: Beat) {
    }


    func metronome(_ metronome: Metronome, willStartWithSuspended beat: Beat?) {
        UIApplication.shared.isIdleTimerDisabled = true
    }


    func metronome(_ metronome: Metronome, willResetDuring beat: Beat?) {
        UIApplication.shared.isIdleTimerDisabled = false
    }
}
