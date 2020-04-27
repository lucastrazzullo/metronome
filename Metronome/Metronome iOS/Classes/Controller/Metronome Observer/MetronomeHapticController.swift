//
//  MetronomeHapticController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 18/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit
import Combine

class MetronomeHapticController {

    private let selectionGenerator = UISelectionFeedbackGenerator()
    private let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)

    private var cancellables = [AnyCancellable]()


    // MARK: Public methods

    func set(statePublisher: MetronomeStatePublisher) {
        cancellables.append(statePublisher.$currentBeat
            .sink(receiveValue: { [weak self] beat in
                guard let beat = beat else { return }
                switch beat.intensity {
                case .normal:
                    self?.impactGenerator.impactOccurred(intensity: 0.5)
                case .strong:
                    self?.impactGenerator.impactOccurred()
                }
            }))

        cancellables.append(statePublisher.$isRunning
            .sink(receiveValue: { [weak self] _ in
                self?.selectionGenerator.selectionChanged()
            }))
    }
}
