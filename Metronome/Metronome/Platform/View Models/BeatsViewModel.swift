//
//  BeatsViewModel.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class BeatsViewModel: ObservableObject {

    @Published private(set) var beats: [BeatViewModel] = []

    let controller: SessionController

    private var cancellable: AnyCancellable?


    // MARK: Object life cycle

    init(sessionController: SessionController) {
        controller = sessionController
        cancellable = controller.sessionPublisher
            .flatMap { $0.$configuration }
            .sink { [weak self] configuration in
                if configuration.timeSignature.barLength.numberOfBeats != self?.beats.count {
                    self?.reloadBeats(configuration.timeSignature.barLength.beats)
                }
        }
    }


    // MARK: Private helper static methods

    private func reloadBeats(_ beats: [Beat]) {
        self.beats = beats.map { beat in
            return BeatViewModel(at: beat.position, controller: controller)
        }
    }
}
