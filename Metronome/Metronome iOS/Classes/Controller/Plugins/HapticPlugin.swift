//
//  HapticPlugin.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 18/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit
import Combine

class HapticPlugin: MetronomePlugin {

    private let selectionGenerator = UISelectionFeedbackGenerator()
    private let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)

    private var cancellables = [AnyCancellable]()


    // MARK: Public methods

    func set(session: MetronomeSession) {
        cancellables.append(session.$currentBeat
            .sink(receiveValue: { [weak self] beat in
                guard let beat = beat else { return }
                self?.impactGenerator.impactOccurred(intensity: beat.isAccent ? 1.0 : 0.5)
            }))

        cancellables.append(session.$isRunning
            .sink(receiveValue: { [weak self] _ in
                self?.selectionGenerator.selectionChanged()
            }))
    }
}
