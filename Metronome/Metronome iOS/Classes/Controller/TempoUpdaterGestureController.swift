//
//  TempoUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class TempoUpdaterGestureController: DefaultGestureMetronomeController {

    private var tempoUpdaterViewController: TempoUpdaterViewController?


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        let recogniser = UIPanGestureRecognizer()
        recogniser.minimumNumberOfTouches = 2
        super.init(with: metronome, gestureRecogniser: recogniser)
        recogniser.delegate = self
    }


    required init(with metronome: Metronome, gestureRecogniser: UIGestureRecognizer) {
        super.init(with: metronome, gestureRecogniser: gestureRecogniser)
    }


    // MARK: UI Callbacks

    override func handleGestureBegan(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureBegan(for: gestureRecogniser)

        if let delegate = delegate {
            tempoUpdaterViewController = TempoUpdaterViewController(tempo: metronome.configuration.tempo)
            delegate.addChildViewController(tempoUpdaterViewController!, in: delegate.view)
        }
    }


    override func handleGestureChanged(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureChanged(for: gestureRecogniser)

        if let delegate = delegate, let gestureRecogniser = gestureRecogniser as? UIPanGestureRecognizer {
            tempoUpdaterViewController?.updateBpm(with: Int(-gestureRecogniser.translation(in: delegate.view).y / 8))
        }
    }

    override func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureEnded(for: gestureRecogniser)

        if let tempo = tempoUpdaterViewController?.tempo {
            metronome.updateTempo(tempo)
            delegate?.removeChildViewController(tempoUpdaterViewController)
        }
    }
}


extension TempoUpdaterGestureController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer, let view = delegate?.view {
            return abs(gestureRecognizer.velocity(in: view).y) > abs(gestureRecognizer.velocity(in: view).x)
        } else {
            return false
        }
    }
}
