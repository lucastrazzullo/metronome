//
//  MetronomeSessionPluginsController.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 23/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

protocol SessionPlugin {
    func set(session: MetronomeSession)
}


class MetronomeSessionPluginsController {

    private let plugins: [SessionPlugin]

    init(session: MetronomeSession, plugins: [SessionPlugin]) {
        self.plugins = plugins
        self.plugins.forEach { controller in
            controller.set(session: session)
        }
    }
}
