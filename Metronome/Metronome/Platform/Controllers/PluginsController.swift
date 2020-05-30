//
//  MetronomeSessionPluginsController.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 23/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

protocol MetronomePlugin {
    func set(session: MetronomeSession)
}


class PluginsController {

    private let plugins: [MetronomePlugin]
    private var cancellables: Set<AnyCancellable> = []


    // MARK: Object life cycle

    init(with pluginList: [MetronomePlugin], sessionController: SessionController) {
        plugins = pluginList

        sessionController.sessionPublisher
            .sink(receiveValue: set(session:))
            .store(in: &cancellables)
    }


    // MARK: Session

    private func set(session: MetronomeSession) {
        plugins.forEach { controller in
            controller.set(session: session)
        }
    }
}
