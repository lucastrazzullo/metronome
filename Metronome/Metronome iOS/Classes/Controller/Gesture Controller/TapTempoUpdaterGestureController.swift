//
//  TapTempoUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class TapTempoUpdaterGestureController: DefaultGestureMetronomeController {

    private weak var tempoTapUpdaterViewController: TapTempoUpdaterViewController?


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
}


extension TapTempoUpdaterGestureController: TapTempoUpdaterViewControllerDelegate {

    func tapTempoUpdaterViewController(_ viewController: TapTempoUpdaterViewController, hasSetNew tempo: Tempo) {
        metronome.updateTempo(tempo)
        dismissPresentedViewController()
    }
}
