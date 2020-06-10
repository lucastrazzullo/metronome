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

class RemoteSessionController: NSObject {

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

        session.snapshotPublisher()
            .filter { $0.owner == .watch }
            .removeDuplicates { $0.configuration == $1.configuration && $0.isRunning == $1.isRunning }
            .sink(receiveValue: didUpdateWithSnapshot)
            .store(in: &cancellables)
    }


    private func didUpdateWithSnapshot(_ snapshot: MetronomeSession.Snapshot) {
        guard WCSession.default.isCompanionAppInstalled else { return }
        guard WCSession.default.isReachable else { return }

        guard let dictionary = try? DictionaryEncoder<[String: Any]>().encode(snapshot) else { return }
        WCSession.default.sendMessage(dictionary, replyHandler: nil, errorHandler: nil)
    }
}


extension RemoteSessionController: SessionController {

    func start() {
        session?.set(isRunning: true, owner: .watch)
    }


    func reset() {
        session?.set(isRunning: false, owner: .watch)
    }


    func toggleIsRunning() {
        if let isRunning = session?.isRunning {
            session?.set(isRunning: !isRunning, owner: .watch)
        }
    }


    func toggleIsSoundOn() {
        if let isSoundOn = session?.isSoundOn {
            session?.set(isSoundOn: !isSoundOn, owner: .watch)
        }
    }


    func set(configuration: MetronomeConfiguration) {
        session?.set(configuration: configuration, owner: .watch)
    }


    func set(timeSignature: TimeSignature) {
        if var configuration = session?.configuration {
            configuration.timeSignature = timeSignature
            session?.set(configuration: configuration, owner: .watch)
        }
    }


    func set(tempo: Tempo) {
        if var configuration = session?.configuration {
            configuration.tempo = tempo
            session?.set(configuration: configuration, owner: .watch)
        }
    }


    func set(isAccent: Bool, forBeatAt position: Int) {
        if var configuration = session?.configuration {
            configuration.setAccent(isAccent, onBeatWith: position)
            session?.set(configuration: configuration, owner: .watch)
        }
    }


    func set(tempoBpm: Int) {
        if var configuration = session?.configuration {
            configuration.setBpm(tempoBpm)
            session?.set(configuration: configuration, owner: .watch)
        }
    }


    func set(snapshot: MetronomeSession.Snapshot) {
        if let session = session {
            session.update(with: snapshot)
        } else {
            set(session: MetronomeSession(withSnapshot: snapshot))
        }
    }
}


extension RemoteSessionController: WCSessionDelegate {

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }


    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async {
            guard let snapshot = try? DictionaryDecoder().decode(MetronomeSession.Snapshot.self, from: applicationContext) else { return }
            guard snapshot.owner == .phone else { return }
            self.set(snapshot: snapshot)
        }
    }


    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            guard let snapshot = try? DictionaryDecoder().decode(MetronomeSession.Snapshot.self, from: message) else { return }
            guard snapshot.owner == .phone else { return }
            self.set(snapshot: snapshot)
        }
    }
}
