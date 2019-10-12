//
//  NoteLengthUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class NoteLengthUpdaterGestureController: DefaultGestureMetronomeController {

    private var timeSignatureUpdaterViewController: TimeSignatureUpdaterViewController?


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        let recogniser = UIPinchGestureRecognizer()
        super.init(with: metronome, gestureRecogniser: recogniser)
    }


    required init(with metronome: Metronome, gestureRecogniser: UIGestureRecognizer) {
        super.init(with: metronome, gestureRecogniser: gestureRecogniser)
    }


    // MARK: UI Callbacks

    override func handleGestureBegan(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureBegan(for: gestureRecogniser)

        if let delegate = delegate {
            timeSignatureUpdaterViewController = TimeSignatureUpdaterViewController(timeSignature: metronome.configuration.timeSignature)
            delegate.addChildViewController(timeSignatureUpdaterViewController!, in: delegate.view)
        }
    }


    override func handleGestureChanged(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureChanged(for: gestureRecogniser)

        if let gestureRecogniser = gestureRecogniser as? UIPinchGestureRecognizer {
            timeSignatureUpdaterViewController?.updateNoteLength(with: (Int(round(gestureRecogniser.scale * 10)) - 10) / 2)
        }
    }

    override func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureEnded(for: gestureRecogniser)

        if let timeSignature = timeSignatureUpdaterViewController?.timeSignature {
            metronome.updateTimeSignature(timeSignature)
            delegate?.removeChildViewController(timeSignatureUpdaterViewController)
        }
    }
}
