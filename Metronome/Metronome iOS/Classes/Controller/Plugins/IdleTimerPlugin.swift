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

    private var cancellables = [AnyCancellable]()


    // MARK: Public methods

    func set(session: MetronomeSession) {
        cancellables.append(
            session.$isRunning
                .sink { isRunning in
                    UIApplication.shared.isIdleTimerDisabled = isRunning
                }
        )
    }
}
