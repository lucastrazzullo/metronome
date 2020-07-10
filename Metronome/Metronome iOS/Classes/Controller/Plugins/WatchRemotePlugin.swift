//
//  WatchRemotePlugin.swift
//  Metronome Cocoa iOS
//
//  Created by luca strazzullo on 19/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine
import WatchConnectivity

class WatchRemotePlugin: NSObject, MetronomePlugin {
    
    private let controller: SessionController
    private var cancellables: Set<AnyCancellable> = []


    // MARK: Object life cycle

    init(controller: SessionController) {
        self.controller = controller
        super.init()
    }


    // MARK: Session

    func set(session: MetronomeSession) {
        if WCSession.isSupported() {
            let watchKitSession = WCSession.default
            watchKitSession.delegate = self
            watchKitSession.activate()
        }

        session.snapshotPublisher()
            .filter { $0.owner == .phone }
            .removeDuplicates { $0.configuration == $1.configuration && $0.isRunning == $1.isRunning }
            .sink(receiveValue: didUpdateWithSnapshot)
            .store(in: &cancellables)
    }


    private func didUpdateWithSnapshot(with snapshot: MetronomeSession.Snapshot) {
        guard WCSession.default.isWatchAppInstalled else { return }
        guard let dictionary = try? DictionaryEncoder<[String: Any]>().encode(snapshot) else { return }

        if WCSession.default.isReachable {
            WCSession.default.sendMessage(dictionary, replyHandler: nil, errorHandler: nil)
        } else if let contextSnapshot = try? DictionaryDecoder().decode(MetronomeSession.Snapshot.self, from: WCSession.default.applicationContext), contextSnapshot != snapshot {
            try? WCSession.default.updateApplicationContext(dictionary)
        }
    }
}


extension WatchRemotePlugin: WCSessionDelegate {

    func sessionDidBecomeInactive(_ session: WCSession) {
    }


    func sessionDidDeactivate(_ session: WCSession) {
    }


    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }


    func sessionReachabilityDidChange(_ session: WCSession) {
        DispatchQueue.main.async {
            guard let snapshot = self.controller.session?.currentSnapshot() else { return }
            guard snapshot.owner == .phone else { return }
            guard let dictionary = try? DictionaryEncoder<[String: Any]>().encode(snapshot) else { return }

            if WCSession.default.isReachable {
                WCSession.default.sendMessage(dictionary, replyHandler: nil, errorHandler: nil)
            }
        }
    }


    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            guard let snapshot = try? DictionaryDecoder().decode(MetronomeSession.Snapshot.self, from: message) else { return }
            guard snapshot.owner == .watch else { return }
            self.controller.set(snapshot: snapshot)
        }
    }
}
