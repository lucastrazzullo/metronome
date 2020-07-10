//
//  SessionViewModel.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class SessionViewModel {

    let controller: SessionController


    // MARK: Object life cycle

    init(sessionController: SessionController) {
        controller = sessionController
    }


    // MARK Public methods

    func toggleIsRunning() {
        controller.toggleIsRunning()
    }
}
