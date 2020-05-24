//
//  MetronomeSessionPluginsController.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 23/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

protocol MetronomePlugin {
    func set(session: MetronomeSession)
}


class PluginsController {

    private let plugins: [MetronomePlugin]

    init(session: MetronomeSession, plugins: [MetronomePlugin]) {
        self.plugins = plugins
        self.plugins.forEach { controller in
            controller.set(session: session)
        }
    }
}
