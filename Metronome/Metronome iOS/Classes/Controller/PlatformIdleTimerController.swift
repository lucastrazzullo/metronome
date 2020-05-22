//
//  PlatformIdleTimerController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 5/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import UIKit
import Combine

class PlatformIdleTimerController: MetronomeObserver {

    private var cancellables = [AnyCancellable]()


    // MARK: Public methods

    func set(publisher: MetronomePublisher) {
        cancellables.append(
            publisher.$isRunning
                .sink { isRunning in
                    UIApplication.shared.isIdleTimerDisabled = isRunning
                }
        )
    }
}
