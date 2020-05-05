//
//  TogglerGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class TogglerGestureController: DefaultGestureController {

    // MARK: Object life cycle

    init(with metronome: Metronome) {
        let recogniser = UITapGestureRecognizer()
        super.init(with: recogniser, metronome: metronome)
    }


    // MARK: Gesture life cycle

    override func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureEnded(for: gestureRecogniser)
        metronome.toggle()
    }
}
