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

    private let metronomeController: MetronomeController
    private let pluginsController: PluginsController


    //  MARK: Object life cycle

    required init?(coder: NSCoder) {
        let cache = MetronomeStateCache(entry: UserDefaultBackedEntryCache())
        let metronome = Metronome(with: cache.configuration, soundOn: cache.isSoundOn)
        metronomeController = DefaultMetronomeController(metronome: metronome)
        pluginsController = PluginsController(session: metronomeController.session, plugins: [
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
        metronomeController.set(configuration: configuration)
    }


    func startMetronome(with configuration: MetronomeConfiguration) {
        metronomeController.set(configuration: configuration)
        metronomeController.start()
    }


    func resetMetronome() {
        metronomeController.reset()
    }
}
