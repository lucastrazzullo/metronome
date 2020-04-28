//
//  MetronomeViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

class MetronomeViewController: UIHostingController<MetronomeView>, ContainerViewController {

    private var metronomePublisher: MetronomeStatePublisher
    private var gesturesController: MetronomeGesturesController

    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    init(with metronomePublisher: MetronomeStatePublisher) {
        self.metronomePublisher = metronomePublisher
        self.gesturesController = MetronomeGesturesController(with: metronomePublisher.metronome)

        let viewModel = MetronomeViewModel(snapshot: metronomePublisher.snapshot())
        let view = MetronomeView(model: viewModel, reset: metronomePublisher.metronome.reset)
        super.init(rootView: view)

        gesturesController.presentingViewController = self

        cancellables.append(
            metronomePublisher.$isRunning
                .sink { isRunning in UIApplication.shared.isIdleTimerDisabled = isRunning }
        )

        cancellables.append(
            metronomePublisher.snapshotPublisher()
                .map(MetronomeViewModel.init)
                .sink(receiveValue: { [weak self] model in
                    self?.rootView.model = model
                })
        )
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
