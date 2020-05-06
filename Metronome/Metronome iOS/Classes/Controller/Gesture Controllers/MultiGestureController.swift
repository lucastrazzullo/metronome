//
//  GesturesController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 21/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

protocol GestureController {
    var gestureRecogniser: UIGestureRecognizer { get }
    func set(targetViewController: UIContainerViewController)
}


class MultiGestureController {

    private let metronome: Metronome
    private var controllers: [GestureController] = []


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome
        self.controllers = buildControllers()
    }


    // MARK: Public methods

    func set(rootViewController: UIContainerViewController) {
        controllers.forEach() { controller in
            controller.set(targetViewController: rootViewController)
        }
    }


    // MARK: Private helper methods

    private func buildControllers() -> [GestureController] {
        let togglerController = TogglerGestureController(with: metronome)
        let helpController = HelpGestureController(with: metronome)
        let tempoSlidePickerController = SlideTempoUpdaterGestureController(with: metronome)
        let tempoTapPickerController = TapTempoUpdaterGestureController(with: metronome)
        let barLengthPickerController = BarLengthPickerGestureController(with: metronome)
        let noteLengthPickerController = NoteLengthPickerGestureController(with: metronome)

        togglerController.gestureRecogniser.canBePrevented(by: helpController.gestureRecogniser)
        togglerController.gestureRecogniser.canBePrevented(by: tempoTapPickerController.gestureRecogniser)

        return [
            togglerController,
            helpController,
            tempoSlidePickerController,
            tempoTapPickerController,
            barLengthPickerController,
            noteLengthPickerController
        ]
    }
}
