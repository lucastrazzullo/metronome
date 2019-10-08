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

    private let observableMetronome: ObservableMetronome<MetronomeViewModel>
    private var observer: Cancellable?

    private let impactGenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft)


    // MARK: Object life cycle

    init(with observableMetronome: ObservableMetronome<MetronomeViewModel>) {
        self.observableMetronome = observableMetronome
        super.init(rootView: MetronomeView(observed: observableMetronome))
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: View life cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        observer = observableMetronome.$snapshot.sink(receiveValue: { [weak self] value in
            if let isRunning = value?.isRunning, isRunning {
                UIApplication.shared.isIdleTimerDisabled = true
            } else {
                UIApplication.shared.isIdleTimerDisabled = false
            }
            if value?.currentIteration != self?.rootView.observed.snapshot.currentIteration {
                self?.impactGenerator.impactOccurred()
            }
        })
    }


    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        observableMetronome.reset()
        observer?.cancel()
    }
}
