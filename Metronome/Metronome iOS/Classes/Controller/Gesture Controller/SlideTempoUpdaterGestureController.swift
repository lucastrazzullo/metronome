//
//  SlideTempoUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class SlideTempoUpdaterGestureController: DefaultMetronomeGestureController<OffsetTempoUpdaterViewController> {

    // MARK: Object life cycle

    init(with metronome: MetronomeController) {
        let recogniser = UIPanGestureRecognizer()
        recogniser.minimumNumberOfTouches = 2
        super.init(with: recogniser, metronome: metronome)
        recogniser.delegate = self
    }


    // MARK: Gesture life cycle

    override func handleGestureBegan(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureBegan(for: gestureRecogniser)

        let viewController = OffsetTempoUpdaterViewController(bpm: metronome.configuration.tempo.bpm)
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

        if let bpm = presentedViewController?.bpm {
            metronome.configuration.setBpm(bpm)
        }
        removeChildViewController()
    }
}


extension SlideTempoUpdaterGestureController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer, let view = gestureRecognizer.view {
            return abs(gestureRecognizer.velocity(in: view).y) > abs(gestureRecognizer.velocity(in: view).x)
        } else {
            return false
        }
    }
}
