//
//  MetronomeGestureViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 5/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

class MetronomeGestureViewController: UIHostingController<MetronomeChromeView>, ContainerViewController {

    private let metronome: ObservableMetronome<MetronomeViewModel>
    private var gestureControllers: [GestureController]


    // MARK: Object life cycle

    init(with metronome: ObservableMetronome<MetronomeViewModel>) {
        self.metronome = metronome
        self.gestureControllers = []
        super.init(rootView: MetronomeChromeView(observed: metronome))
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: View life cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .clear

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


    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeGestureControllers()
    }


    // MARK: Private helper methods

    private func addGestureController(_ gestureController: GestureController) {
        gestureController.delegate = self
        gestureControllers.append(gestureController)
    }


    private func removeGestureControllers() {
        gestureControllers.forEach({ $0.delegate = nil })
        gestureControllers.removeAll()
    }
}
