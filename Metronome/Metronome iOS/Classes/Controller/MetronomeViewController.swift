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
    private var gesturesController: DefaultGesturesController

    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    init(with metronomePublisher: MetronomePublisher) {
        self.metronomePublisher = metronomePublisher
        self.gesturesController = DefaultGesturesController(with: metronomePublisher.metronome)

        let viewModel = MetronomeViewModel(metronomePublisher: metronomePublisher)
        let view = AnyView(MetronomeView().environmentObject(viewModel))
        super.init(rootView: view)

        gesturesController.presentingViewController = self

        cancellables.append(
            metronomePublisher.$isRunning
                .sink { isRunning in UIApplication.shared.isIdleTimerDisabled = isRunning }
        )
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
