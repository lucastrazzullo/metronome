//
//  GestureMetronomePlayerViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 5/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class GestureMetronomePlayerViewController: UIViewController, ContainerViewController {

    private let metronome: Metronome
    private var gestureControllers: [GestureController]


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        self.metronome = metronome
        self.gestureControllers = []
        super.init(nibName: nil, bundle: nil)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let helpController = HelpGestureController(with: metronome)
        addGestureController(helpController)

        let togglerController = TogglerGestureController(with: metronome)
        addGestureController(togglerController)

        let tempoUpdaterController = TempoUpdaterGestureController(with: metronome)
        addGestureController(tempoUpdaterController)

        let barLengthController = BarLengthUpdaterGestureController(with: metronome)
        addGestureController(barLengthController)

        let noteLengthController = NoteLengthUpdaterGestureController(with: metronome)
        addGestureController(noteLengthController)

        let tempoTapUpdaterController = TapTempoUpdaterGestureController(with: metronome)
        addGestureController(tempoTapUpdaterController)

        togglerController.gestureRecogniser.canBePrevented(by: helpController.gestureRecogniser)
        togglerController.gestureRecogniser.canBePrevented(by: tempoTapUpdaterController.gestureRecogniser)
    }


    // MARK: Public methods

    func addGestureController(_ gestureController: GestureController) {
        gestureController.delegate = self
        gestureControllers.append(gestureController)
    }
}
