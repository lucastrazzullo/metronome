//
//  BarLengthUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit
import Combine

class BarLengthUpdaterGestureController: NSObject, GestureController {

    let gestureRecogniser: UIGestureRecognizer

    private let metronome: Metronome
    private var viewModel: BarLengthPickerViewModel

    private weak var targetViewController: UIContainerViewController?
    private weak var presentedViewController: UIViewController?


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        self.metronome = metronome
        self.viewModel = BarLengthPickerViewModel(timeSignature: metronome.configuration.timeSignature)
        self.gestureRecogniser = {
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
        switch gestureRecogniser.state {
        case .began:
            presentTimeSignaturePicker()
        case .changed:
            updateBarLength(with: gestureRecogniser.translation(in: gestureRecogniser.view).x)
        case .ended:
            complete()
        default:
            break
        }
    }


    // MARK: Private helper methods

    private func presentTimeSignaturePicker() {
        metronome.reset()

        viewModel = BarLengthPickerViewModel(timeSignature: metronome.configuration.timeSignature)

        let pickerViewController = TimeSignaturePickerViewController(viewModel: viewModel)
        presentedViewController = pickerViewController
        targetViewController?.addChildViewController(pickerViewController, in: targetViewController?.view)
    }


    private func updateBarLength(with offset: CGFloat) {
        viewModel.apply(barLength: Int(offset))
    }


    private func complete() {
        metronome.configuration.setTimeSignature(viewModel.selectedTimeSignature)
        targetViewController?.removeChildViewController(presentedViewController)
    }
}


extension BarLengthUpdaterGestureController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer, let view = gestureRecognizer.view {
            return abs(gestureRecognizer.velocity(in: view).y) < abs(gestureRecognizer.velocity(in: view).x)
        } else {
            return false
        }
    }
}
