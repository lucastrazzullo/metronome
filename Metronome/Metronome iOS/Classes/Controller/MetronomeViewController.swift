//
//  MetronomeViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

class MetronomeViewController: UIHostingController<AnyView>, ContainerViewController {

    private var metronomePublisher: MetronomePublisher
    private var gesturesController: GesturesController


    // MARK: Object life cycle

    init(with metronomePublisher: MetronomePublisher) {
        self.metronomePublisher = metronomePublisher
        self.gesturesController = GesturesController()

        let viewModel = MetronomeViewModel(metronomePublisher: metronomePublisher)
        let view = AnyView(MetronomeView(viewModel: viewModel))
        super.init(rootView: view)

        addGestureControllers()
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Private helper methods

    private func addGestureControllers() {
        let helpController = HelpGestureController(with: metronomePublisher.metronome)
        let togglerController = TogglerGestureController(with: metronomePublisher.metronome)
        let tempoUpdaterController = SlideTempoUpdaterGestureController(with: metronomePublisher.metronome)
        let barLengthController = BarLengthUpdaterGestureController(with: metronomePublisher.metronome)
        let noteLengthController = NoteLengthUpdaterGestureController(with: metronomePublisher.metronome)
        let tempoTapUpdaterController = TapTempoUpdaterGestureController(with: metronomePublisher.metronome)

        togglerController.gestureRecogniser.canBePrevented(by: helpController.gestureRecogniser)
        togglerController.gestureRecogniser.canBePrevented(by: tempoTapUpdaterController.gestureRecogniser)

        gesturesController.presentingViewController = self
        gesturesController.addGestureControllers([helpController,
                                                  togglerController,
                                                  tempoUpdaterController,
                                                  barLengthController,
                                                  noteLengthController,
                                                  tempoTapUpdaterController])
    }
}
