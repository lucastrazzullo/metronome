//
//  MetronomeHapticViewController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 18/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class MetronomeHapticViewController: UIViewController {

    private let selectionGenerator = UISelectionFeedbackGenerator()
    private let notificationGenerator = UINotificationFeedbackGenerator()
    private let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)


    init(with metronomeDispatcher: MetronomeDispatcher) {
        super.init(nibName: nil, bundle: nil)
        metronomeDispatcher.addObserver(self)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MetronomeHapticViewController: MetronomeObserver {

    func metronome(_ metronome: Metronome, didUpdate configuration: MetronomeConfiguration) {
    }


    func metronome(_ metronome: Metronome, didPulse beat: MetronomeBeat) {
        switch beat.intensity {
        case .normal:
            impactGenerator.impactOccurred(intensity: 0.5)
        case .strong:
            impactGenerator.impactOccurred()
        }
    }


    func metronome(_ metronome: Metronome, willStartWithSuspended beat: MetronomeBeat?) {
        selectionGenerator.selectionChanged()
    }


    func metronome(_ metronome: Metronome, willResetDuring beat: MetronomeBeat?) {
        selectionGenerator.selectionChanged()
    }
}
