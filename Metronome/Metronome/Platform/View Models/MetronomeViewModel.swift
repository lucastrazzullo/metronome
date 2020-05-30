//
//  MetronomeViewModel.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class MetronomeViewModel {

    let controller: SessionController


    // MARK: Object life cycle

    init(metronomeController: SessionController) {
        controller = metronomeController
    }


    // MARK Public methods

    func toggleIsRunning() {
        controller.toggleIsRunning()
    }
}
