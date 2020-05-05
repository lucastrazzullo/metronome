//
//  SlideTempoUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class SlideTempoUpdaterGestureController: DefaultGestureController<TempoPickerViewController> {

    private var viewModel: SlideTempoPickerViewModel!


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
        presentTempoePicker()
    }


    override func handleGestureChanged(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureChanged(for: gestureRecogniser)
        if let gestureRecogniser = gestureRecogniser as? UIPanGestureRecognizer {
            updateTempo(with: -gestureRecogniser.translation(in: gestureRecogniser.view).y / 8)
        }
    }


    override func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureEnded(for: gestureRecogniser)
        complete()
    }


    // MARK: Private helper methods

    private func presentTempoePicker() {
        viewModel = SlideTempoPickerViewModel(bpm: metronome.configuration.tempo.bpm)
        addChildViewController(TempoPickerViewController(viewModel: viewModel))
    }


    private func updateTempo(with offset: CGFloat) {
        viewModel.apply(offset: Int(offset))
    }


    private func complete() {
        metronome.configuration.setBpm(viewModel.selectedTempoBpm)
        removeChildViewController()
    }
}


extension SlideTempoUpdaterGestureController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer, let view = gestureRecognizer.view {
            return abs(gestureRecognizer.velocity(in: view).y) > abs(gestureRecognizer.velocity(in: view).x)
        } else {
            return false
        }
    }
}
