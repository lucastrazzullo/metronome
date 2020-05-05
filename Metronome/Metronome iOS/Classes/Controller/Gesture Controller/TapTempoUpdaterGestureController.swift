//
//  TapTempoUpdaterGestureController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 12/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class TapTempoUpdaterGestureController: DefaultGestureController<TapTempoUpdaterViewController> {

    private let idleTimeBeforeSet: TimeInterval = 2

    private var idleTimer: Timer?


    // MARK: Object life cycle

    init(with metronome: Metronome) {
        let recogniser = UILongPressGestureRecognizer()
        recogniser.minimumPressDuration = 1
        super.init(with: recogniser, metronome: metronome)
    }


    // MARK: Gesture life cycle

    override func handleGestureBegan(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureBegan(for: gestureRecogniser)

        let viewController = TapTempoUpdaterViewController()
        viewController.delegate = self
        presentViewController(viewController)
    }


    override func handleGestureEnded(for gestureRecogniser: UIGestureRecognizer) {
        super.handleGestureEnded(for: gestureRecogniser)
        starCompletionTimer(with: metronome.configuration.tempo.bpm)
    }


    // MARK: Private helper methods

    private func starCompletionTimer(with bpm: Int) {
        idleTimer?.invalidate()
        idleTimer = Timer.scheduledTimer(withTimeInterval: idleTimeBeforeSet, repeats: false, block: {
            [weak self] timer in
            self?.complete(with: bpm)
        })
    }


    private func complete(with bpm: Int) {
        metronome.configuration.setBpm(bpm)
        dismissPresentedViewController()
    }
}


extension TapTempoUpdaterGestureController: TapTempoUpdaterViewControllerDelegate {

    func tapTempoUpdaterViewController(_ viewController: TapTempoUpdaterViewController, bpmFor timestamps: [TimeInterval]) -> Int? {
        guard let frequency = getFrequency(for: timestamps) else { return nil }
        let bpm = metronome.configuration.getBmp(with: frequency)
        starCompletionTimer(with: bpm)
        return bpm
    }


    // MARK: Private helper methods

    private func getFrequency(for tapTimestamps: [TimeInterval]) -> TimeInterval? {
        guard tapTimestamps.count >= 2 else { return nil }

        let frequencies: [Double] = tapTimestamps.enumerated().compactMap { index, timestamp in
            if index + 1 == tapTimestamps.count {
                return nil
            } else {
                return tapTimestamps[index + 1] - timestamp
            }
        }

        return frequencies.reduce(0, +) / Double(frequencies.count)
    }
}
