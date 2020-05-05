//
//  HelpGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class HelpGestureController: GestureController {

    let gestureRecogniser: UIGestureRecognizer

    private let metronome: Metronome
    private var targetViewController: UIViewController?


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        self.metronome = metronome
        self.gestureRecogniser = {
            let recogniser = UISwipeGestureRecognizer()
            recogniser.direction = .up
            return recogniser
        }()
    }


    // MARK: Public methods

    func set(targetViewController: UIContainerViewController) {
        gestureRecogniser.addTarget(self, action: #selector(handleGestureRecogniser(with:)))

        self.targetViewController = targetViewController
        self.targetViewController?.view.addGestureRecognizer(gestureRecogniser)
    }


    // MARK: UI Callbacks

    @objc private func handleGestureRecogniser(with gestureRecogniser: UIGestureRecognizer) {
        if gestureRecogniser.state == .ended {
            metronome.reset()
            targetViewController?.present(TipsViewController(completion: dismiss), animated: true)
        }
    }


    private func dismiss() {
        targetViewController?.dismiss(animated: true, completion: nil)
    }
}
