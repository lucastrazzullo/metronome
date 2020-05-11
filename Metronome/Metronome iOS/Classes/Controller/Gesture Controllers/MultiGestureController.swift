//
//  GesturesController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 21/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

protocol GestureController {
    var gestureRecogniser: UIGestureRecognizer { get }
    func set(targetViewController: UIContainerViewController)
}


class MultiGestureController {

    private var controllers: [GestureController] = []


    // MARK: Public methods

    func set(gestureControllers: [GestureController], with rootViewController: UIContainerViewController) {
        controllers = gestureControllers
        controllers.forEach() { controller in
            controller.set(targetViewController: rootViewController)
        }
    }
}
