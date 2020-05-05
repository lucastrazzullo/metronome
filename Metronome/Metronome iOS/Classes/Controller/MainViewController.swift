//
//  MainViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ContainerViewController {

    private let metronomeApplicationSettingsController: MetronomeApplicationSettingsController
    private let metronomeHapticController: MetronomeHapticController
    private let metronomeCacheController: MetronomeCacheController

    private let metronome: Metronome
    private let metronomePublisher: MetronomePublisher


    //  MARK: Object life cycle

    required init?(coder: NSCoder) {
        metronomeApplicationSettingsController = MetronomeApplicationSettingsController()
        metronomeHapticController = MetronomeHapticController()
        metronomeCacheController = MetronomeCacheController(entry: UserDefaultBackedEntryCache())

        metronome = Metronome(with: metronomeCacheController.buildConfigurationWithCachedValues())
        metronomePublisher = MetronomePublisher(metronome: metronome)

        super.init(coder: coder)
    }


    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        metronomeHapticController.set(publisher: metronomePublisher)
        metronomeCacheController.set(publisher: metronomePublisher)
        metronomeApplicationSettingsController.set(publisher: metronomePublisher)

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
