//
//  UIForceTapGestureRecogniser.swift
//  Metronome
//
//  Created by luca strazzullo on 6/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class UIForceTapGestureRecogniser: UIGestureRecognizer {

    private var forceRegognised: Bool = false
    private var forceMaximumRecognised: Bool = false


    // MARK: Touches

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event!)

        guard let firstTouch = touches.first else {
            return
        }

        if firstTouch.force >= firstTouch.maximumPossibleForce / 2, forceRegognised == false {
            forceRegognised = true
            state = .began
        }
        if firstTouch.force >= firstTouch.maximumPossibleForce, forceMaximumRecognised == false {
            forceMaximumRecognised = true
            state = .changed
        }
    }


    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        if forceRegognised {
            state = .ended
        } else {
            state = .cancelled
        }
    }


    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        if forceRegognised {
            state = .ended
        } else {
            state = .cancelled
        }
    }


    override func reset() {
        super.reset()

        forceRegognised = false
        forceMaximumRecognised = false
    }
}
