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

    let controller: MetronomeController

    private var cancellable: AnyCancellable?


    // MARK: Object life cycle

    init(metronomeController: MetronomeController) {
        controller = metronomeController
        cancellable = controller.session.configurationPublisher().sink { [weak self] configuration in
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
