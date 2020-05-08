//
//  MetronomeSoundController.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 7/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine
import AVFoundation

class MetronomeSoundController: ObservingController {

    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    init() {
        try? AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
    }


    // MARK: Public methods

    func set(publisher: MetronomePublisher) {
        cancellables.append(Publishers.CombineLatest(publisher.$currentBeat, publisher.$isSoundOn).sink { beat, isSoundOn in
            guard let beat = beat, isSoundOn else { return }
            switch beat.intensity {
            case .normal:
                AudioServicesPlaySystemSound(1157)
            case .strong:
                AudioServicesPlaySystemSound(1306)
            }
        })
    }
}
