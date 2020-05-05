//
//  GesturesController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 21/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

protocol GestureController: AnyObject {
    var presentingViewController: UIContainerViewController? { get set }
    var gestureRecogniser: UIGestureRecognizer { get }
}


class GesturesController {

    weak var presentingViewController: UIContainerViewController? {
        didSet {
            gestureControllers.forEach({
                $0.presentingViewController = presentingViewController
            })
        }
    }

    private var gestureControllers: [GestureController] = []


    // MARK: Public methods

    func addGestureControllers(_ controllers: [GestureController]) {
        controllers.forEach(addGestureController(_:))
    }


    func addGestureController(_ gestureController: GestureController) {
        gestureController.presentingViewController = presentingViewController
        gestureControllers.append(gestureController)
    }


    func removeGestureControllers() {
        gestureControllers.forEach({ $0.presentingViewController = nil })
        gestureControllers.removeAll()
    }
}
