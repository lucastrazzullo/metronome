//
//  MainViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ContainerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = MetronomeConfiguration(timeSignature: TimeSignature.default, tempo: Tempo.default)
        let metronome = Metronome(with: configuration)

        let metronomeViewController = MetronomeViewController(with: metronome)
        addChildViewController(metronomeViewController, in: view)

        let metronomeGestureViewController = MetronomeGestureViewController(with: metronomeViewController.metronomeObserver)
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
