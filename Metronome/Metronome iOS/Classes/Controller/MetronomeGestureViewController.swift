//
//  MetronomeGestureViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 5/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

class MetronomeGestureViewController: UIHostingController<ChromeView>, ContainerViewController {

    private let metronomeObserver: MetronomeObserver<MetronomeViewModel>
    private var gestureControllers: [GestureController]


    // MARK: Object life cycle

    init(with metronomeObserver: MetronomeObserver<MetronomeViewModel>) {
        self.metronomeObserver = metronomeObserver
        self.gestureControllers = []
        super.init(rootView: ChromeView(metronomeObserver: metronomeObserver))
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: View life cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .clear

        let helpController = HelpGestureController(with: metronomeObserver.metronome)
        addGestureController(helpController)

        let togglerController = TogglerGestureController(with: metronomeObserver.metronome)
        addGestureController(togglerController)

        let tempoUpdaterController = TempoUpdaterGestureController(with: metronomeObserver.metronome)
        addGestureController(tempoUpdaterController)

        let barLengthController = BarLengthUpdaterGestureController(with: metronomeObserver.metronome)
        addGestureController(barLengthController)

        let noteLengthController = NoteLengthUpdaterGestureController(with: metronomeObserver.metronome)
        addGestureController(noteLengthController)

        let tempoTapUpdaterController = TapTempoUpdaterGestureController(with: metronomeObserver.metronome)
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
