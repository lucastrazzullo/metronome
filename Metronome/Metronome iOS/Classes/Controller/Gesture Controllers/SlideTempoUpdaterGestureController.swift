//
//  SlideTempoUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class SlideTempoUpdaterGestureController: NSObject, GestureController {

    let gestureRecogniser: UIGestureRecognizer

    private let metronome: Metronome
    private var viewModel: SlideTempoPickerViewModel

    private weak var targetViewController: UIContainerViewController?
    private weak var presentedViewController: UIViewController?


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        self.metronome = metronome
        self.viewModel = SlideTempoPickerViewModel(bpm: metronome.configuration.tempo.bpm)
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
            presentTempoPicker()
        case .changed:
            updateTempo(with: -gestureRecogniser.translation(in: gestureRecogniser.view).y / 8)
        case .ended:
            complete()
        default:
            break
        }
    }


    // MARK: Private helper methods

    private func presentTempoPicker() {
        metronome.reset()

        viewModel = SlideTempoPickerViewModel(bpm: metronome.configuration.tempo.bpm)

        let pickerViewController = TempoPickerViewController(viewModel: viewModel)
        presentedViewController = pickerViewController
        targetViewController?.addChildViewController(pickerViewController, in: targetViewController?.view)
    }


    private func updateTempo(with offset: CGFloat) {
        viewModel.apply(offset: Int(offset))
    }


    private func complete() {
        metronome.configuration.setBpm(viewModel.selectedTempoBpm)
        targetViewController?.removeChildViewController(presentedViewController)
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
