//
//  HelpGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class HelpGestureController: DefaultGestureMetronomeController<TipsViewController> {

    // MARK: Object life cycle

    init(with metronome: Metronome) {
        let recogniser = UISwipeGestureRecognizer()
        recogniser.direction = .up
        super.init(with: metronome, gestureRecogniser: recogniser)
    }


    required init(with metronome: Metronome, gestureRecogniser: UIGestureRecognizer) {
        super.init(with: metronome, gestureRecogniser: gestureRecogniser)
    }


    // MARK: Gesture life cycle

    override func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureEnded(for: gestureRecogniser)

        let tips = TipsViewModelRepository.all
        let viewModel = HelpViewModel(tips: tips)
        let view = TipsView(model: viewModel, dismiss: dismissPresentedViewController)
        let viewController = TipsViewController(rootView: view)
        presentViewController(viewController)
    }
}
