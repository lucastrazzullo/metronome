//
//  MainViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ContainerViewController {

    private let metronome: Metronome
    private let metronomeDispatcher: MetronomeDispatcher


    //  MARK: Object life cycle

    required init?(coder: NSCoder) {
        metronome = Metronome(with: MetronomeConfiguration(timeSignature: TimeSignature.default, tempo: Tempo.default))
        metronomeDispatcher = MetronomeDispatcher(with: metronome)
        super.init(coder: coder)
    }


    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let metronomeHapticViewController = MetronomeHapticViewController(with: metronomeDispatcher)
        addChildViewController(metronomeHapticViewController, in: view)

        let metronomeViewController = MetronomeViewController(with: metronomeDispatcher, metronome: metronome)
        addChildViewController(metronomeViewController, in: view)

        let metronomeGestureViewController = MetronomeGestureViewController(with: metronomeDispatcher, metronome: metronome)
        addChildViewController(metronomeGestureViewController, in: view)

        let oneTimeWelcomeViewController = WelcomeViewController()
        oneTimeWelcomeViewController.delegate = self
        addChildViewController(oneTimeWelcomeViewController, in: view)
    }
}


extension MainViewController: WelcomeViewControllerDelegate {

    func welcomeViewControllerHasCompleted(_ viewController: WelcomeViewController) {
        removeChildViewController(viewController)
    }
}
