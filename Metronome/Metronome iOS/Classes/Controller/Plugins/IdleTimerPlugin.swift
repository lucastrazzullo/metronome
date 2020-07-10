//
//  IdleTimerPlugin.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 5/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import UIKit
import Combine

class IdleTimerPlugin: MetronomePlugin {

    private var cancellables = Set<AnyCancellable>()


    // MARK: Public methods

    func set(session: MetronomeSession) {
        session.$isRunning
            .sink { isRunning in UIApplication.shared.isIdleTimerDisabled = isRunning }
            .store(in: &cancellables)
    }
}
