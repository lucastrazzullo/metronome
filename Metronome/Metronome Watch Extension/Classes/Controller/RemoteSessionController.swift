//
//  RemoteSessionController.swift
//  Metronome CocoaTests
//
//  Created by luca strazzullo on 22/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine
import WatchConnectivity

class RemoteSessionController: NSObject, SessionController {

    var sessionPublisher: AnyPublisher<MetronomeSession, Never> {
        return currentSessionPublisher.ignoreNil().eraseToAnyPublisher()
    }
    var session: MetronomeSession? {
        return currentSessionPublisher.value
    }

    private let currentSessionPublisher = CurrentValueSubject<MetronomeSession?, Never>(nil)
    private var cancellables: Set<AnyCancellable> = []


    // MARK: Object lifecycle

    override init() {
        super.init()

        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }


    // MARK: Session

    private func set(session: MetronomeSession) {
        currentSessionPublisher.send(session)

        session.$configuration
            .removeDuplicates()
            .sink(receiveValue: didUpdateConfiguration)
            .store(in: &cancellables)
    }


    private func didUpdateConfiguration(_ configuration: MetronomeConfiguration) {
        guard WCSession.default.isCompanionAppInstalled else { return }

        let currentContextConfiguration = try? DictionaryDecoder().decode(MetronomeConfiguration.self, from: WCSession.default.applicationContext)
        guard WCSession.default.isReachable, currentContextConfiguration != configuration else { return }

        guard let dictionary = try? DictionaryEncoder<[String: Any]>().encode(configuration) else { return }
        WCSession.default.sendMessage(dictionary, replyHandler: nil, errorHandler: nil)
    }


    // MARK: Public methods

    func start() {
    }

    
    func reset() {
    }


    func toggleIsRunning() {
    }


    func toggleIsSoundOn() {
    }


    func set(configuration: MetronomeConfiguration) {
        if session == nil {
            set(session: MetronomeSession(configuration: configuration, isSoundOn: false, isRunning: false, currentBeat: nil))
        } else {
            session?.configuration = configuration
        }
    }


    func set(timeSignature: TimeSignature) {
        session?.configuration.timeSignature = timeSignature
    }


    func set(tempo: Tempo) {
        session?.configuration.tempo = tempo
    }


    func set(isAccent: Bool, forBeatAt position: Int) {
        session?.configuration.setAccent(isAccent, onBeatWith: position)
    }


    func set(tempoBpm: Int) {
        session?.configuration.setBpm(tempoBpm)
    }
}


extension RemoteSessionController: WCSessionDelegate {

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }


    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let configuration = try? DictionaryDecoder().decode(MetronomeConfiguration.self, from: applicationContext) {
            DispatchQueue.main.async { [weak self] in
                self?.set(configuration: configuration)
            }
        }
    }


    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let configuration = try? DictionaryDecoder().decode(MetronomeConfiguration.self, from: message) {
            DispatchQueue.main.async { [weak self] in
                self?.set(configuration: configuration)
            }
        }
    }
}
