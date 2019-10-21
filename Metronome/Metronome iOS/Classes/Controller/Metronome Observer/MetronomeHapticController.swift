//
//  MetronomeHapticController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 18/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class MetronomeHapticController {
    private let selectionGenerator = UISelectionFeedbackGenerator()
    private let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
}


extension MetronomeHapticController: MetronomeObserver {

    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
    }


    func metronome(_ metronome: Metronome, didPulse beat: Beat) {
        switch beat.intensity {
        case .normal:
            impactGenerator.impactOccurred(intensity: 0.5)
        case .strong:
            impactGenerator.impactOccurred()
        }
    }


    func metronome(_ metronome: Metronome, willStartWithSuspended beat: Beat?) {
        selectionGenerator.selectionChanged()
    }


    func metronome(_ metronome: Metronome, willResetDuring beat: Beat?) {
        selectionGenerator.selectionChanged()
    }
}
