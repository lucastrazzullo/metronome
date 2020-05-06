//
//  BarLengthPickerGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit
import Combine

class BarLengthPickerGestureController: NSObject, GestureController {

    let gestureRecogniser: UIGestureRecognizer

    private let viewModel: BarLengthPickerViewModel

    private weak var targetViewController: UIContainerViewController?
    private weak var presentedViewController: UIViewController?


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        viewModel = BarLengthPickerViewModel(metronome: metronome)
        gestureRecogniser = {
            let recogniser = UIPanGestureRecognizer()
            recogniser.minimumNumberOfTouches = 2
            return recogniser
        }()
        super.init()
    }


    // MARK: Public methods

    func set(targetViewController: UIContainerViewController) {
        gestureRecogniser.addTarget(self, action: #selector(handleGestureRecogniser(with:)))
        gestureRecogniser.delegate = self

        self.targetViewController = targetViewController
        self.targetViewController?.view.addGestureRecognizer(gestureRecogniser)
    }


    // MARK: UI Callbacks

    @objc private func handleGestureRecogniser(with gestureRecogniser: UIPanGestureRecognizer) {
        handleViewModel(with: gestureRecogniser)
        handlePresentation(with: gestureRecogniser)
    }


    private func handleViewModel(with gestureRecogniser: UIPanGestureRecognizer) {
        switch gestureRecogniser.state {
        case .began:
            viewModel.startSelection()
        case .changed:
            viewModel.selectTemporary(barLength: Int(gestureRecogniser.translation(in: gestureRecogniser.view).x))
        case .ended:
            viewModel.commit()
        default:
            break
        }
    }


    private func handlePresentation(with gestureRecogniser: UIPanGestureRecognizer) {
        switch gestureRecogniser.state {
        case .began:
            let pickerViewController = TimeSignaturePickerViewController(viewModel: viewModel)
            presentedViewController = pickerViewController
            targetViewController?.addChildViewController(pickerViewController, in: targetViewController?.view)
        case .ended:
            targetViewController?.removeChildViewController(presentedViewController)
        default:
            break
        }
    }
}


extension BarLengthPickerGestureController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer, let view = gestureRecognizer.view {
            return abs(gestureRecognizer.velocity(in: view).y) < abs(gestureRecognizer.velocity(in: view).x)
        } else {
            return false
        }
    }
}
