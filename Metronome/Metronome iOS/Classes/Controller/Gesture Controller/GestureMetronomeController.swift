//
//  GestureMetronomeController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class GestureMetronomeController<PresentedControllerType: UIViewController>: NSObject, GestureController {

    weak var presentedViewController: PresentedControllerType? {
        didSet {
            metronome.reset()
        }
    }
    weak var presentingViewController: UIContainerViewController? {
        didSet {
            setupOrTearDown()
        }
    }

    let gestureRecogniser: UIGestureRecognizer
    let metronome: Metronome


    // MARK: Object life cycle

    init(with gestureRecogniser: UIGestureRecognizer, metronome: Metronome) {
        self.gestureRecogniser = gestureRecogniser
        self.metronome = metronome
        super.init()

        gestureRecogniser.addTarget(self, action: #selector(handleGestureRecogniser))
    }


    // MARK: Setup

    private func setupOrTearDown() {
        if presentingViewController == nil {
            tearDown()
        } else {
            setup()
        }
    }


    private func setup() {
        presentingViewController?.view.addGestureRecognizer(gestureRecogniser)
    }


    private func tearDown() {
        presentingViewController?.view.removeGestureRecognizer(gestureRecogniser)
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
        if let presentingViewController = presentingViewController {
            presentingViewController.addChildViewController(viewController, in: presentingViewController.view)
            presentedViewController = viewController
        }
    }


    func presentViewController(_ viewController: PresentedControllerType) {
        if let presentingViewController = presentingViewController {
            presentingViewController.present(viewController, animated: true, completion: nil)
            presentedViewController = viewController
        }
    }


    func removeChildViewController() {
        presentingViewController?.removeChildViewController(presentedViewController)
    }


    func dismissPresentedViewController() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
