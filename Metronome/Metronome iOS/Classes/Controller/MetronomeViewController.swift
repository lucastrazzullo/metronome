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

    let metronomeObserver: MetronomeObserver<MetronomeViewModel>
    private var snapshotObserver: Cancellable?

    private let impactGenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft)


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        self.metronomeObserver = MetronomeObserver<MetronomeViewModel>(with: metronome)
        super.init(rootView: MetronomeView(metronomeObserver: metronomeObserver))
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: View life cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        snapshotObserver = metronomeObserver.$snapshot.sink(receiveValue: { [weak self] snapShot in
            if let isRunning = snapShot?.isRunning, isRunning {
                UIApplication.shared.isIdleTimerDisabled = true
            } else {
                UIApplication.shared.isIdleTimerDisabled = false
            }
            if snapShot?.currentIteration != self?.rootView.metronomeObserver.snapshot.currentIteration {
                self?.impactGenerator.impactOccurred()
            }
        })
    }


    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        metronomeObserver.metronome.reset()
        snapshotObserver?.cancel()
    }
}
