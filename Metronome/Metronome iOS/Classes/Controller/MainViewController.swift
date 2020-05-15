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

    private let metronome: Metronome
    private let metronomePublisher: MetronomePublisher

    private let cache: MetronomeStateCache


    //  MARK: Object life cycle

    required init?(coder: NSCoder) {
        cache = MetronomeStateCache(entry: UserDefaultBackedEntryCache())

        metronome = Metronome(with: cache.configuration, soundOn: cache.isSoundOn)
        metronomePublisher = MetronomePublisher(metronome: metronome)

        observerControllers = MultiObservingController(cache: cache)

        super.init(coder: coder)
    }


    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addObservingControllers()
        addViewControllers()
    }


    // MARK: Public methods

    func startMetronome(with timeSignature: TimeSignature) {
        metronome.configuration.timeSignature = timeSignature
        metronome.start()
    }


    func resetMetronome() {
        metronome.reset()
    }


    // MARK: Private helper methods

    private func addObservingControllers() {
        let controllers: [ObservingController] = [
            MetronomeApplicationSettingsController(),
            MetronomeHapticController(),
            MetronomeCacheController(cache: cache),
            MetronomeSoundController(),
            MetronomeUserActivityController(metronome: metronome)
        ]

        observerControllers.set(observingControllers: controllers, with: metronomePublisher)
    }


    private func addViewControllers() {
        addChildViewController(MetronomeViewController(with: metronomePublisher), in: view)
    }
}
