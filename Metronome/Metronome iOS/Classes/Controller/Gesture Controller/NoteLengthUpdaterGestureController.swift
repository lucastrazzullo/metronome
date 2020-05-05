//
//  NoteLengthUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class NoteLengthUpdaterGestureController: DefaultGestureController<TimeSignaturePickerViewController> {

    private var viewModel: NoteLengthPickerViewModel!


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        let recogniser = UIPinchGestureRecognizer()
        super.init(with: recogniser, metronome: metronome)
    }


    // MARK: Gesture life cycle

    override func handleGestureBegan(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureBegan(for: gestureRecogniser)
        presentTimeSignaturePicker()
    }


    override func handleGestureChanged(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureChanged(for: gestureRecogniser)
        if let gestureRecogniser = gestureRecogniser as? UIPinchGestureRecognizer {
            updateNoteLength(with: (Int(round(gestureRecogniser.scale * 10)) - 10) / 2)
        }
    }


    override func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureEnded(for: gestureRecogniser)
        complete()
    }


    // MARK: Private helper methods

    private func presentTimeSignaturePicker() {
        viewModel = NoteLengthPickerViewModel(timeSignature: metronome.configuration.timeSignature)
        addChildViewController(TimeSignaturePickerViewController(viewModel: viewModel))
    }


    private func updateNoteLength(with offset: Int) {
        viewModel.apply(noteLength: offset)
    }


    private func complete() {
        metronome.configuration.setTimeSignature(viewModel.selectedTimeSignature)
        removeChildViewController()
    }
}
