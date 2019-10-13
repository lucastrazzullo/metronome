//
//  HelpGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class HelpGestureController: DefaultGestureMetronomeController<HelpViewController> {

    // MARK: Object life cycle

    init(with metronome: Metronome) {
        let recogniser = UIForceTapGestureRecogniser()
        super.init(with: metronome, gestureRecogniser: recogniser)
    }


    required init(with metronome: Metronome, gestureRecogniser: UIGestureRecognizer) {
        super.init(with: metronome, gestureRecogniser: gestureRecogniser)
    }


    // MARK: Gesture life cycle

    override func handleGestureBegan(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureBegan(for: gestureRecogniser)

        let viewController = HelpViewController(rootView: HelpView(model: HelpViewModel()))
        presentViewController(viewController)
    }
}
