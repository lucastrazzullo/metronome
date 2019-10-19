//
//  MetronomeHapticViewController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 18/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class MetronomeHapticViewController: UIViewController {

    private let impactGenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)


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


    func metronome(_ metronome: Metronome, didTick iteration: Int) {
        if iteration == 1 {
            impactGenerator.impactOccurred()
        } else {
            impactGenerator.impactOccurred(intensity: 0.5)
        }
    }


    func metronome(_ metronome: Metronome, didStartAt iteration: Int) {
        impactGenerator.impactOccurred(intensity: 0.2)
    }


    func metronome(_ metronome: Metronome, didResetAt iteration: Int) {
        impactGenerator.impactOccurred(intensity: 0.2)
    }
}
