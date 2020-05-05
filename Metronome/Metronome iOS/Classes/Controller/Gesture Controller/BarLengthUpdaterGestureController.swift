//
//  BarLengthUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit
import Combine

class BarLengthUpdaterGestureController: DefaultGestureController<TimeSignaturePickerViewController> {

    private var viewModel: BarLengthPickerViewModel!


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        let recogniser = UIPanGestureRecognizer()
        recogniser.minimumNumberOfTouches = 2
        super.init(with: recogniser, metronome: metronome)
        recogniser.delegate = self
    }


    // MARK: Gesture life cycle

    override func handleGestureBegan(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureBegan(for: gestureRecogniser)
        presentTimeSignaturePicker()
    }


    override func handleGestureChanged(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureChanged(for: gestureRecogniser)
        if let gestureRecogniser = gestureRecogniser as? UIPanGestureRecognizer {
            updateBarLength(with: gestureRecogniser.translation(in: gestureRecogniser.view).x)
        }
    }


    override func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureEnded(for: gestureRecogniser)
        complete()
    }


    // MARK: Private helper methods

    private func presentTimeSignaturePicker() {
        viewModel = BarLengthPickerViewModel(timeSignature: metronome.configuration.timeSignature)
        addChildViewController(TimeSignaturePickerViewController(viewModel: viewModel))
    }


    private func updateBarLength(with offset: CGFloat) {
        viewModel.apply(barLength: Int(offset))
    }


    private func complete() {
        metronome.configuration.setTimeSignature(viewModel.selectedTimeSignature)
        removeChildViewController()
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
