//
//  HelpGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class HelpGestureController: DefaultGestureMetronomeController {

    private weak var helpViewController: HelpViewController?
    private let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        let recogniser = UIForceTapGestureRecogniser()
        super.init(with: metronome, gestureRecogniser: recogniser)
    }


    required init(with metronome: Metronome, gestureRecogniser: UIGestureRecognizer) {
        super.init(with: metronome, gestureRecogniser: gestureRecogniser)
    }


    // MARK: Gesture life cycle

    override func handleGestureBegan(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureBegan(for: gestureRecogniser)

        impactGenerator.impactOccurred()
        metronome.reset()

        let helpViewController = HelpViewController(rootView: HelpView(model: HelpViewModel()))
        delegate?.present(helpViewController, animated: true, completion: nil)
        self.helpViewController = helpViewController
    }


    override func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureEnded(for: gestureRecogniser)

        impactGenerator.impactOccurred(intensity: 0.5)
        helpViewController?.dismiss(animated: true, completion: nil)
    }
}
