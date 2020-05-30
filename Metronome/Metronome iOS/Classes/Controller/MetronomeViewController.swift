//
//  MetronomeViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit

class MetronomeViewController: UIViewController, ContainerViewController {

    private let sessionController: SessionController
    private let pluginsController: PluginsController


    //  MARK: Object life cycle

    required init?(coder: NSCoder) {
        let cache = MetronomeStateCache(entry: UserDefaultBackedEntryCache())
        let metronome = Metronome(with: cache.configuration, soundOn: cache.isSoundOn)
        sessionController = MetronomeSessionController(metronome: metronome)
        pluginsController = PluginsController(with: [
            PlatformIdleTimerPlugin(),
            HapticPlugin(),
            CachePlugin(cache: cache),
            SoundPlugin(),
            UserActivityPlugin(controller: sessionController),
            WatchRemotePlugin(controller: sessionController)
        ], sessionController: sessionController)
        super.init(coder: coder)
    }


    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(MetronomeHostingController(with: sessionController), in: view)
    }


    // MARK: Public methods

    func setupMetronome(with configuration: MetronomeConfiguration) {
        sessionController.set(configuration: configuration)
    }


    func startMetronome(with configuration: MetronomeConfiguration) {
        sessionController.set(configuration: configuration)
        sessionController.start()
    }


    func resetMetronome() {
        sessionController.reset()
    }
}
