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

    struct SoundURL {
        static let normal = Bundle.main.url(forResource: "Beat-normal", withExtension: "mp3")!
        static let highlighted = Bundle.main.url(forResource: "Beat-highlighted", withExtension: "mp3")!
    }

    private let engine: AVAudioEngine
    private var players: [AnyHashable: AVAudioPlayerNode] = [:]
    private var buffers: [AnyHashable: AVAudioPCMBuffer] = [:]
    private var audios: [AnyHashable: AVAudioFile] = [:]

    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    init() {
        try? AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .spokenAudio)
        try? AVAudioSession.sharedInstance().setActive(true)

        engine = AVAudioEngine()
        engine.isAutoShutdownEnabled = true
    }


    // MARK: Public methods

    func set(publisher: MetronomePublisher) {
        cancellables.append(publisher.$configuration.sink { [weak self] configuration in
            guard let engine = self?.engine else { return }
            engine.stop()

            self?.players.values.forEach({ player in
                player.reset()
                engine.disconnectNodeInput(player)
            })
            self?.players.removeAll()
            self?.buffers.removeAll()
            self?.audios.removeAll()

            for beat in configuration.timeSignature.beats {
                let soundURL: URL = {
                    switch beat.intensity {
                    case .normal:
                        return SoundURL.normal
                    case .strong:
                        return SoundURL.highlighted
                    }
                }()
                guard let audio = try? AVAudioFile(forReading: soundURL) else { return }

                let player = AVAudioPlayerNode()
                engine.attach(player)
                engine.connect(player, to: engine.mainMixerNode, format: audio.processingFormat)
                player.scheduleFile(audio, at: AVAudioTime(sampleTime: 0, atRate: audio.processingFormat.sampleRate))

                let audioFormat = audio.processingFormat
                let audioFrameCount = UInt32(audio.length)
                let buffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount)!

                try? audio.read(into: buffer)

                self?.audios[beat.position] = audio
                self?.buffers[beat.position] = buffer
                self?.players[beat.position] = player
            }
            try? engine.start()
        })

        cancellables.append(publisher.$currentBeat.sink { [weak self, weak publisher] beat in
            guard publisher?.isSoundOn == true, self?.engine.isRunning == true,
                let beat = beat,
                let buffer = self?.buffers[beat.position]
                else { return }

            self?.players[beat.position]?.stop()
            self?.players[beat.position]?.scheduleBuffer(buffer, completionHandler: nil)
            self?.players[beat.position]?.play()
        })
    }
}
