//
//  MetronomeViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit
import WatchConnectivity

class MetronomeViewController: UIViewController, ContainerViewController {

    private let metronome: Metronome
    private let metronomeController: MetronomeController
    private let metronomeSessionBinder: MetronomeSessionPluginsController

    private let cache: MetronomeStateCache


    //  MARK: Object life cycle

    required init?(coder: NSCoder) {
        cache = MetronomeStateCache(entry: UserDefaultBackedEntryCache())

        metronome = Metronome(with: cache.configuration, soundOn: cache.isSoundOn)
        metronomeController = DefaultMetronomeController(metronome: metronome)
        metronomeSessionBinder = MetronomeSessionPluginsController(session: metronomeController.session, plugins: [
            PlatformIdleTimerPlugin(),
            HapticPlugin(),
            CachePlugin(cache: cache),
            SoundPlugin(),
            UserActivityPlugin(controller: metronomeController),
            WatchConnectivityPlugin(controller: metronomeController)
        ])

        super.init(coder: coder)
    }


    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(MetronomeHostingController(with: metronomeController), in: view)
    }


    // MARK: Public methods

    func setupMetronome(with configuration: MetronomeConfiguration) {
        metronome.configuration = configuration
    }


    func startMetronome(with configuration: MetronomeConfiguration) {
        metronome.configuration = configuration
        metronome.start()
    }


    func resetMetronome() {
        metronome.reset()
    }
}
