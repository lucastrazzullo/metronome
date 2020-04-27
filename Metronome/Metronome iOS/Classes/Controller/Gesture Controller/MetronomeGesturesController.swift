//
//  MetronomeGesturesController.swift
//  Metronome
//
//  Created by luca strazzullo on 5/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class MetronomeGesturesController: GesturesController {

    // MARK: Object life cycle

    init(with metronome: MetronomeController) {
        super.init(with: MetronomeGesturesController.buildControllers(with: metronome))
    }


    // MARK: Builder

    private static func buildControllers(with metronome: MetronomeController) -> [GestureController] {
        let helpController = HelpGestureController(with: metronome)
        let togglerController = TogglerGestureController(with: metronome)
        let tempoUpdaterController = SlideTempoUpdaterGestureController(with: metronome)
        let barLengthController = BarLengthUpdaterGestureController(with: metronome)
        let noteLengthController = NoteLengthUpdaterGestureController(with: metronome)
        let tempoTapUpdaterController = TapTempoUpdaterGestureController(with: metronome)

        togglerController.gestureRecogniser.canBePrevented(by: helpController.gestureRecogniser)
        togglerController.gestureRecogniser.canBePrevented(by: tempoTapUpdaterController.gestureRecogniser)

        return [
            helpController,
            togglerController,
            tempoUpdaterController,
            barLengthController,
            noteLengthController,
            tempoTapUpdaterController
        ]
    }
}
