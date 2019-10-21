//
//  NoteLengthUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class NoteLengthUpdaterGestureController: DefaultMetronomeGestureController<TimeSignatureUpdaterViewController> {

    // MARK: Object life cycle

    init(with metronome: Metronome) {
        let recogniser = UIPinchGestureRecognizer()
        super.init(with: recogniser, metronome: metronome)
    }


    // MARK: Gesture life cycle

    override func handleGestureBegan(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureBegan(for: gestureRecogniser)

        let viewController = TimeSignatureUpdaterViewController(timeSignature: metronome.configuration.timeSignature)
        addChildViewController(viewController)
    }


    override func handleGestureChanged(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureChanged(for: gestureRecogniser)

        if let gestureRecogniser = gestureRecogniser as? UIPinchGestureRecognizer {
            presentedViewController?.updateNoteLength(with: (Int(round(gestureRecogniser.scale * 10)) - 10) / 2)
        }
    }


    override func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureEnded(for: gestureRecogniser)

        if let timeSignature = presentedViewController?.timeSignature {
            metronome.configuration.timeSignature = timeSignature
        }
        removeChildViewController()
    }
}
