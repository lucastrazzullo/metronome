//
//  TapTempoUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class TapTempoUpdaterGestureController: DefaultGestureMetronomeController<TapTempoUpdaterViewController> {

    private var timer: Timer?


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        let gestureRecogniser = UILongPressGestureRecognizer()
        gestureRecogniser.minimumPressDuration = 1
        super.init(with: metronome, gestureRecogniser: gestureRecogniser)
    }


    required init(with metronome: Metronome, gestureRecogniser: UIGestureRecognizer) {
        super.init(with: metronome, gestureRecogniser: gestureRecogniser)
    }


    // MARK: Gesture life cycle

    override func handleGestureBegan(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureBegan(for: gestureRecogniser)

        let viewController = TapTempoUpdaterViewController(configuration: metronome.configuration)
        viewController.delegate = self
        presentViewController(viewController)
    }


    override func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureEnded(for: gestureRecogniser)

        startIdleTimer()
    }


    // MARK: Private helper methods

    private func startIdleTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {
            [weak self] timer in
            self?.complete()
        })
    }


    private func complete() {
        if let tempo = presentedViewController?.tempo {
            metronome.updateTempo(tempo)
        }
        dismissPresentedViewController()
    }
}


extension TapTempoUpdaterGestureController: TapTempoUpdaterViewControllerDelegate {

    func tapTempoUpdaterViewController(_ viewController: TapTempoUpdaterViewController, hasSetNew tempo: Tempo) {
        startIdleTimer()
    }
}
