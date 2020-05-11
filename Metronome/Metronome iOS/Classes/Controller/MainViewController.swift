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

    private let cache: MetronomeStateCache


    //  MARK: Object life cycle

    required init?(coder: NSCoder) {
        cache = MetronomeStateCache(entry: UserDefaultBackedEntryCache())

        metronome = Metronome(with: cache.configuration, soundOn: cache.isSoundOn)
        metronomePublisher = MetronomePublisher(metronome: metronome)

        observerControllers = MultiObservingController(cache: cache)
        gestureControllers = MultiGestureController()

        super.init(coder: coder)
    }


    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addObservingControllers()
        addGestureControllers()
        addViewControllers()
    }


    // MARK: Public methods

    func startMetronome(with timeSignature: TimeSignature) {
        metronome.configuration.timeSignature = timeSignature
        metronome.start()
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


    private func addGestureControllers() {
        let tempoSlidePickerController = SlideTempoPickerGestureController(with: metronome)
        let tempoTapPickerController = TapTempoPickerGestureController(with: metronome)
        let barLengthPickerController = BarLengthPickerGestureController(with: metronome)
        let noteLengthPickerController = NoteLengthPickerGestureController(with: metronome)
        let togglerController = TogglerGestureController(with: metronome)
        togglerController.gestureRecogniser.canBePrevented(by: tempoTapPickerController.gestureRecogniser)

        let controllers: [GestureController] = [
            togglerController,
            tempoSlidePickerController,
            tempoTapPickerController,
            barLengthPickerController,
            noteLengthPickerController
        ]

        gestureControllers.set(gestureControllers: controllers, with: self)
    }


    private func addViewControllers() {
        addChildViewController(MetronomeViewController(with: metronomePublisher), in: view)
    }
}
