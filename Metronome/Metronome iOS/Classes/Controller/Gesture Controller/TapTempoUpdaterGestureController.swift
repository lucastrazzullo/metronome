//
//  TapTempoUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit
import Combine

class TapTempoUpdaterGestureController: DefaultGestureController {

    private var viewModel: TapTempoPickerViewModel!

    private let idleTimeBeforeSet: TimeInterval = 2
    private var idleTimer: Timer?

    private var cancellable: AnyCancellable?


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        let recogniser = UILongPressGestureRecognizer()
        recogniser.minimumPressDuration = 1
        super.init(with: recogniser, metronome: metronome)
    }


    // MARK: Gesture life cycle

    override func handleGestureBegan(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureBegan(for: gestureRecogniser)
        presentTapTempoPicker()
    }


    override func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureEnded(for: gestureRecogniser)
        starCompletionTimer()
    }


    // MARK: Private helper methods

    private func presentTapTempoPicker() {
        viewModel = TapTempoPickerViewModel()
        presentViewController(TapTempoPickerViewController(viewModel: viewModel))

        cancellable = viewModel.$selectedTempoBpm.sink { [weak self] _ in
            self?.starCompletionTimer()
        }

        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(updateTempo))
        gestureRecogniser.numberOfTapsRequired = 1
        presentedViewController?.view.addGestureRecognizer(gestureRecogniser)
    }


    @objc private func updateTempo(with gestureRecogniser: UITapGestureRecognizer) {
        switch gestureRecogniser.state {
        case .recognized:
            viewModel.apply(newTapWith: Date().timeIntervalSinceReferenceDate)
        default:
            break
        }
    }


    private func starCompletionTimer() {
        idleTimer?.invalidate()
        idleTimer = Timer.scheduledTimer(withTimeInterval: idleTimeBeforeSet, repeats: false, block: {
            [weak self] timer in
            self?.complete()
        })
    }


    private func complete() {
        if let bpm = viewModel.selectedTempoBpm {
            metronome.configuration.setBpm(bpm)
        }
        dismissPresentedViewController()
    }
}
