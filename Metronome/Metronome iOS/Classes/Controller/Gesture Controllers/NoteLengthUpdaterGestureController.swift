//
//  NoteLengthUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class NoteLengthUpdaterGestureController: GestureController {

    let gestureRecogniser: UIGestureRecognizer

    private let metronome: Metronome
    private var viewModel: NoteLengthPickerViewModel

    private weak var targetViewController: UIContainerViewController?
    private weak var presentedViewController: UIViewController?


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        self.metronome = metronome
        self.viewModel = NoteLengthPickerViewModel(timeSignature: metronome.configuration.timeSignature)
        self.gestureRecogniser = UIPinchGestureRecognizer()        
    }


    // MARK: Public methods

    func set(targetViewController: UIContainerViewController) {
        gestureRecogniser.addTarget(self, action: #selector(handleGestureRecogniser(with:)))

        self.targetViewController = targetViewController
        self.targetViewController?.view.addGestureRecognizer(gestureRecogniser)
    }


    // MARK: UI Callbacks

    @objc private func handleGestureRecogniser(with gestureRecogniser: UIPinchGestureRecognizer) {
        switch gestureRecogniser.state {
        case .began:
            presentTimeSignaturePicker()
        case .changed:
            updateNoteLength(with: (Int(round(gestureRecogniser.scale * 10)) - 10) / 2)
        case .ended:
            complete()
        default:
            break
        }
    }


    // MARK: Private helper methods

    private func presentTimeSignaturePicker() {
        metronome.reset()

        viewModel = NoteLengthPickerViewModel(timeSignature: metronome.configuration.timeSignature)

        let pickerViewController = TimeSignaturePickerViewController(viewModel: viewModel)
        presentedViewController = pickerViewController
        targetViewController?.addChildViewController(pickerViewController, in: targetViewController?.view)
    }


    private func updateNoteLength(with offset: Int) {
        viewModel.apply(noteLength: offset)
    }


    private func complete() {
        metronome.configuration.setTimeSignature(viewModel.selectedTimeSignature)
        targetViewController?.removeChildViewController(presentedViewController)
    }
}
