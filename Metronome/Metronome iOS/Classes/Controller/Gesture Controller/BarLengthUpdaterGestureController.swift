//
//  BarLengthUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class BarLengthUpdaterGestureController: DefaultGestureMetronomeController<TimeSignatureUpdaterViewController> {

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

        let viewController = TimeSignatureUpdaterViewController(timeSignature: metronome.configuration.timeSignature)
        addChildViewController(viewController)
    }


    override func handleGestureChanged(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureChanged(for: gestureRecogniser)

        if let gestureRecogniser = gestureRecogniser as? UIPanGestureRecognizer {
            presentedViewController?.updateBarLength(with: Int(gestureRecogniser.translation(in: gestureRecogniser.view).x))
        }
    }


    override func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureEnded(for: gestureRecogniser)

        if let timeSignature = presentedViewController?.timeSignature {
            metronome.updateTimeSignature(timeSignature)
        }
        removeChildViewController()
    }
}


extension BarLengthUpdaterGestureController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer, let view = gestureRecognizer.view {
            return abs(gestureRecognizer.velocity(in: view).y) < abs(gestureRecognizer.velocity(in: view).x)
        } else {
            return false
        }
    }
}
