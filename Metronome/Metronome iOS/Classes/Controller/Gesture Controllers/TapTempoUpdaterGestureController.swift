//
//  TapTempoUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit
import Combine

class TapTempoUpdaterGestureController: GestureController {

    let gestureRecogniser: UIGestureRecognizer

    private let metronome: Metronome
    private var viewModel: TapTempoPickerViewModel

    private let idleTimeBeforeSet: TimeInterval = 2
    private var idleTimer: Timer?

    private var cancellable: AnyCancellable?

    private weak var targetViewController: UIContainerViewController?
    private weak var presentedViewController: UIViewController?


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        self.metronome = metronome
        self.viewModel = TapTempoPickerViewModel(configuration: metronome.configuration)
        self.gestureRecogniser = {
            let recogniser = UILongPressGestureRecognizer()
            recogniser.minimumPressDuration = 1
            return recogniser
        }()
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
            presentTapTempoPicker()
        case .ended:
            starCompletionTimer()
        default:
            break
        }
    }


    // MARK: Private helper methods

    private func presentTapTempoPicker() {
        metronome.reset()

        viewModel = TapTempoPickerViewModel(configuration: metronome.configuration)
        cancellable = viewModel.$selectedTempoBpm.sink { [weak self] _ in
            self?.starCompletionTimer()
        }

        let pickerViewController = TapTempoPickerViewController(viewModel: viewModel)
        presentedViewController = pickerViewController
        targetViewController?.present(pickerViewController, animated: true)

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
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
