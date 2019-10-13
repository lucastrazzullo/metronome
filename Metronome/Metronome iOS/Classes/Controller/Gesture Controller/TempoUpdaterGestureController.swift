//
//  TempoUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class TempoUpdaterGestureController: DefaultGestureMetronomeController<TempoUpdaterViewController> {

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


    // MARK: Gesture life cycle

    override func handleGestureBegan(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureBegan(for: gestureRecogniser)

        let viewController = TempoUpdaterViewController(tempo: metronome.configuration.tempo)
        addChildViewController(viewController)
    }


    override func handleGestureChanged(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureChanged(for: gestureRecogniser)

        if let gestureRecogniser = gestureRecogniser as? UIPanGestureRecognizer {
            presentedViewController?.updateBpm(with: Int(-gestureRecogniser.translation(in: gestureRecogniser.view).y / 8))
        }
    }


    override func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureEnded(for: gestureRecogniser)

        if let tempo = presentedViewController?.tempo {
            metronome.updateTempo(tempo)
        }
        removeChildViewController()
    }
}


extension TempoUpdaterGestureController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer, let view = gestureRecognizer.view {
            return abs(gestureRecognizer.velocity(in: view).y) > abs(gestureRecognizer.velocity(in: view).x)
        } else {
            return false
        }
    }
}
