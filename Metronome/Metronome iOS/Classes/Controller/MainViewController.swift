//
//  MainViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ContainerViewController {

    private let observerControllers: MultiObservingController
    private let gestureControllers: MultiGestureController

    private let metronome: Metronome
    private let metronomePublisher: MetronomePublisher

    private let cache: ConfigurationCache


    //  MARK: Object life cycle

    required init?(coder: NSCoder) {
        cache = ConfigurationCache(entry: UserDefaultBackedEntryCache())

        metronome = Metronome(with: cache.configuration)
        metronomePublisher = MetronomePublisher(metronome: metronome)

        observerControllers = MultiObservingController(cache: cache)
        gestureControllers = MultiGestureController(metronome: metronome)

        super.init(coder: coder)
    }


    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        observerControllers.set(publisher: metronomePublisher)
        gestureControllers.set(rootViewController: self)

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
