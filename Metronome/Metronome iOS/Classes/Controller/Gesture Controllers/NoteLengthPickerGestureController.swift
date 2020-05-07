//
//  NoteLengthPickerGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class NoteLengthPickerGestureController: GestureController {

    let gestureRecogniser: UIGestureRecognizer

    private let viewModel: NoteLengthPickerViewModel

    private weak var targetViewController: UIContainerViewController?
    private weak var presentedViewController: UIViewController?


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        viewModel = NoteLengthPickerViewModel(metronome: metronome)
        gestureRecogniser = UIPinchGestureRecognizer()        
    }


    // MARK: Public methods

    func set(targetViewController: UIContainerViewController) {
        gestureRecogniser.addTarget(self, action: #selector(handleGestureRecogniser(with:)))

        self.targetViewController = targetViewController
        self.targetViewController?.view.addGestureRecognizer(gestureRecogniser)
    }


    // MARK: UI Callbacks

    @objc private func handleGestureRecogniser(with gestureRecogniser: UIPinchGestureRecognizer) {
        handleViewModel(with: gestureRecogniser)
        handlePresentation(with: gestureRecogniser)
    }


    private func handleViewModel(with gestureRecogniser: UIPinchGestureRecognizer) {
        switch gestureRecogniser.state {
        case .began:
            viewModel.startSelection()
        case .changed:
            viewModel.selectTemporary(noteLength: (Int(round(gestureRecogniser.scale * 10)) - 10) / 2)
        case .ended:
            viewModel.commit()
        default:
            break
        }
    }


    private func handlePresentation(with gestureRecogniser: UIPinchGestureRecognizer) {
        switch gestureRecogniser.state {
        case .began:
            let pickerViewController = TimeSignaturePickerViewController(pickerViewModel: viewModel)
            presentedViewController = pickerViewController
            targetViewController?.addChildViewController(pickerViewController, in: targetViewController?.view)
        case .ended:
            targetViewController?.removeChildViewController(presentedViewController)
        default:
            break
        }
    }
}
