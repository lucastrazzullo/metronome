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

    let controller: MetronomeController


    // MARK: Object life cycle

    init(metronomeController: MetronomeController) {
        controller = metronomeController
    }


    // MARK Public methods

    func toggleIsRunning() {
        controller.toggleIsRunning()
    }
}
