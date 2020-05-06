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

    private var viewModel: TapTempoPickerViewModel

    private let idleTimeBeforeSet: TimeInterval = 2
    private var idleTimer: Timer?
    private var cancellable: AnyCancellable?

    private weak var targetViewController: UIContainerViewController?
    private weak var presentedViewController: UIViewController?


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        viewModel = TapTempoPickerViewModel(metronome: metronome)
        gestureRecogniser = {
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

    @objc private func handleGestureRecogniser(with gestureRecogniser: UILongPressGestureRecognizer) {
        handleViewModel(with: gestureRecogniser)
        handlePresentation(with: gestureRecogniser)
        handleMultiTap(with: gestureRecogniser)
    }


    private func handleViewModel(with gestureRecogniser: UILongPressGestureRecognizer) {
        switch gestureRecogniser.state {
        case .began:
            viewModel.startSelection()
            cancellable = viewModel.$selectedTempoBpm.sink(receiveValue: { [weak self] _ in self?.starCompletionTimer() })
        default:
            break
        }
    }


    private func handlePresentation(with gestureRecogniser: UILongPressGestureRecognizer) {
        switch gestureRecogniser.state {
        case .began:
            let pickerViewController = TapTempoPickerViewController(viewModel: viewModel)
            presentedViewController = pickerViewController
            targetViewController?.present(pickerViewController, animated: true)
        case .ended:
            starCompletionTimer()
        default:
            break
        }
    }


    private func handleMultiTap(with gestureRecogniser: UILongPressGestureRecognizer) {
        if gestureRecogniser.state == .began {
            let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(updateTempo))
            gestureRecogniser.numberOfTapsRequired = 1
            presentedViewController?.view.addGestureRecognizer(gestureRecogniser)
        }
    }


    @objc private func updateTempo(with gestureRecogniser: UITapGestureRecognizer) {
        switch gestureRecogniser.state {
        case .recognized:
            viewModel.selectTemporarely(newTapWith: Date().timeIntervalSinceReferenceDate)
        default:
            break
        }
    }


    // MARK: Private helper methods

    private func starCompletionTimer() {
        idleTimer?.invalidate()
        idleTimer = Timer.scheduledTimer(withTimeInterval: idleTimeBeforeSet, repeats: false, block: {
            [weak self] timer in
            self?.complete()
        })
    }


    private func complete() {
        cancellable = nil
        viewModel.commit()
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
