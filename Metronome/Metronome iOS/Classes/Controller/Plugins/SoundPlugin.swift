//
//  SoundPlugin.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 7/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine
import AVFoundation

class SoundPlugin: MetronomePlugin {

    struct SoundURL {
        static let normal = Bundle.main.url(forResource: "Beat-normal", withExtension: "mp3")!
        static let accent = Bundle.main.url(forResource: "Beat-highlighted", withExtension: "mp3")!
    }

    private var engine: AVAudioEngine?
    private var players: [AnyHashable: AVAudioPlayerNode] = [:]
    private var buffers: [AnyHashable: AVAudioPCMBuffer] = [:]
    private var audios: [AnyHashable: AVAudioFile] = [:]

    private var cancellables: Set<AnyCancellable> = []


    // MARK: Public methods

    func set(session: MetronomeSession) {
        session.$configuration.combineLatest(session.$isSoundOn)
            .sink { [weak self] configuration, isSoundOn in

                if isSoundOn, self?.engine == nil {
                    try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio)
                    try? AVAudioSession.sharedInstance().setActive(true)

                    self?.engine = AVAudioEngine()
                    self?.engine?.isAutoShutdownEnabled = true
                    self?.engine?.mainMixerNode.volume = 1
                }

                if !isSoundOn, self?.engine != nil {
                    self?.engine?.stop()
                    self?.engine = nil

                    try? AVAudioSession.sharedInstance().setCategory(.ambient, mode: .spokenAudio)
                    try? AVAudioSession.sharedInstance().setActive(false)
                }

                guard let engine = self?.engine, isSoundOn else { return }
                engine.stop()

                self?.players.values.forEach({ player in
                    player.reset()
                    if engine.attachedNodes.contains(player) {
                        engine.disconnectNodeInput(player)
                    }
                })
                self?.players.removeAll()
                self?.buffers.removeAll()
                self?.audios.removeAll()

                for beat in configuration.timeSignature.barLength.beats {
                    let soundURL = beat.isAccent ? SoundURL.accent : SoundURL.normal
                    guard let audio = try? AVAudioFile(forReading: soundURL) else { return }

                    let player = AVAudioPlayerNode()
                    engine.attach(player)
                    engine.connect(player, to: engine.mainMixerNode, format: audio.processingFormat)

                    let audioFormat = audio.processingFormat
                    let audioFrameCount = UInt32(audio.length)
                    let buffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount)!

                    try? audio.read(into: buffer)

                    self?.audios[beat.position] = audio
                    self?.buffers[beat.position] = buffer
                    self?.players[beat.position] = player
                }
                try? engine.start()
            }
            .store(in: &cancellables)

        session.$currentBeat
            .sink { [weak self, weak session] beat in
                guard session?.isSoundOn == true, self?.engine?.isRunning == true,
                    let beat = beat, let buffer = self?.buffers[beat.position]
                    else { return }

                self?.players[beat.position]?.stop()
                self?.players[beat.position]?.scheduleBuffer(buffer, completionHandler: nil)
                self?.players[beat.position]?.play()
            }
            .store(in: &cancellables)
    }
}
