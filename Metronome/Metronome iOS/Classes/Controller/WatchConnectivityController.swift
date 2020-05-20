//
//  WatchConnectivityController.swift
//  Metronome Cocoa iOS
//
//  Created by luca strazzullo on 19/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine
import WatchConnectivity

class WatchConnectivityController: NSObject, MetronomeController {

    private var cancellable: AnyCancellable?
    private var metronome: Metronome?


    // MARK: Object life cycle

    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }


    // MARK: Public methods

    func set(publisher: MetronomePublisher) {
        metronome = publisher.metronome
        cancellable = publisher.$configuration.sink { configuration in
            guard let userInfo = try? UserInfoEncoder<[String: Any]>().encode(configuration) else { return }
            guard WCSession.default.isWatchAppInstalled else { return }

            if WCSession.default.isReachable {
                WCSession.default.sendMessage(userInfo, replyHandler: nil, errorHandler: nil)
            } else {
                try? WCSession.default.updateApplicationContext(userInfo)
            }
        }
    }
}


extension WatchConnectivityController: WCSessionDelegate {

    func sessionDidBecomeInactive(_ session: WCSession) {
    }


    func sessionDidDeactivate(_ session: WCSession) {
    }


    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
}
