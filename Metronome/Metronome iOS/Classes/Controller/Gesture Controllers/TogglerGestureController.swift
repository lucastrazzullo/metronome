//
//  TogglerGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class TogglerGestureController: GestureController {

    let gestureRecogniser: UIGestureRecognizer

    private let metronome: Metronome


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        self.metronome = metronome
        self.gestureRecogniser = UITapGestureRecognizer()
    }


    // MARK: Public methods

    func set(targetViewController: UIContainerViewController) {
        gestureRecogniser.addTarget(self, action: #selector(handleGestureRecogniser(with:)))
        targetViewController.view.addGestureRecognizer(gestureRecogniser)
    }


    // MARK: UI Callbacks

    @objc private func handleGestureRecogniser(with gestureRecogniser: UIGestureRecognizer) {
        if gestureRecogniser.state == .ended {
            metronome.toggle()
        }
    }
}
