//
//  DefaultGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class DefaultGestureMetronomeController<PresentedControllerType: UIViewController>: NSObject, GestureController {

    weak var presentedViewController: PresentedControllerType? {
        didSet {
            if presentedViewController != nil {
                metronome.reset()
            }
        }
    }
    weak var delegate: UIContainerViewController? {
        willSet {
            if let delegate = delegate, newValue == nil {
                tearDown(with: delegate)
            }
        }
        didSet {
            if let delegate = delegate {
                setup(with: delegate)
            }
        }
    }

    let gestureRecogniser: UIGestureRecognizer
    let metronome: Metronome


    // MARK: Object life cycle

    required init(with metronome: Metronome, gestureRecogniser: UIGestureRecognizer) {
        self.metronome = metronome
        self.gestureRecogniser = gestureRecogniser
        super.init()

        gestureRecogniser.addTarget(self, action: #selector(handleGestureRecogniser))
    }


    // MARK: Setup

    private func setup(with delegate: UIViewController) {
        delegate.view.addGestureRecognizer(gestureRecogniser)
    }


    private func tearDown(with delegate: UIViewController) {
        delegate.view.removeGestureRecognizer(gestureRecogniser)
    }


    // MARK: UI Callbacks

    @objc private func handleGestureRecogniser(with gestureRecogniser: UIGestureRecognizer) {
        switch gestureRecogniser.state {
        case .began:
            handleGestureBegan(for: gestureRecogniser)
        case .changed:
            handleGestureChanged(for: gestureRecogniser)
        case .ended:
            handleGestureEnded(for: gestureRecogniser)
        default:
            break
        }
    }


    func handleGestureBegan(for gestureRecogniser: UIGestureRecognizer) {
    }


    func handleGestureChanged(for gestureRecogniser: UIGestureRecognizer) {
    }


    func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
    }


    // MARK: Presentation

    func addChildViewController(_ viewController: PresentedControllerType) {
        if let delegate = delegate {
            delegate.addChildViewController(viewController, in: delegate.view)
            presentedViewController = viewController
        }
    }


    func presentViewController(_ viewController: PresentedControllerType) {
        if let delegate = delegate {
            delegate.present(viewController, animated: true, completion: nil)
            presentedViewController = viewController
        }
    }


    func removeChildViewController() {
        delegate?.removeChildViewController(presentedViewController)
    }


    func dismissPresentedViewController() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
