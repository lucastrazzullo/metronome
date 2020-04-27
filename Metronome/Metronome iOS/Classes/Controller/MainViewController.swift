//
//  MainViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ContainerViewController {

    private let metronomeHapticController: MetronomeHapticController
    private let metronomeCacheController: MetronomeCacheController

    private let metronome: MetronomeController
    private let metronomePublisher: MetronomeStatePublisher


    //  MARK: Object life cycle

    required init?(coder: NSCoder) {
        metronomeHapticController = MetronomeHapticController()
        metronomeCacheController = MetronomeCacheController(entry: UserDefaultBackedEntryCache())

        metronome = MetronomeController(with: metronomeCacheController.buildConfigurationWithCachedValues())
        metronomePublisher = MetronomeStatePublisher(metronome: metronome)

        super.init(coder: coder)
    }


    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        metronomeHapticController.set(statePublisher: metronomePublisher)
        metronomeCacheController.set(statePublisher: metronomePublisher)


        let metronomeViewController = MetronomeViewController(with: metronomePublisher)
        addChildViewController(metronomeViewController, in: view)

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
