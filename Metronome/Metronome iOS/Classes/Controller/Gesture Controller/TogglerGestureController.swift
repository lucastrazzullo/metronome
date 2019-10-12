//
//  TogglerGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class TogglerGestureController: DefaultGestureMetronomeController {

    // MARK: Object life cycle

    init(with metronome: Metronome) {
        let recogniser = UITapGestureRecognizer()
        super.init(with: metronome, gestureRecogniser: recogniser)
    }


    required init(with metronome: Metronome, gestureRecogniser: UIGestureRecognizer) {
        super.init(with: metronome, gestureRecogniser: gestureRecogniser)
    }


    // MARK: UI Callbacks

    override func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureEnded(for: gestureRecogniser)
        metronome.toggle()
    }
}
