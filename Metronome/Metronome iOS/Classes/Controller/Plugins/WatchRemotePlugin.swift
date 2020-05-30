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

        session.$configuration
            .removeDuplicates()
            .sink(receiveValue: didUpdateConfiguration)
            .store(in: &cancellables)
    }


    private func didUpdateConfiguration(_ configuration: MetronomeConfiguration) {
        guard WCSession.default.isWatchAppInstalled else { return }
        guard let dictionary = try? DictionaryEncoder<[String: Any]>().encode(configuration) else { return }

        let currentContextConfiguration = try? DictionaryDecoder().decode(MetronomeConfiguration.self, from: WCSession.default.applicationContext)
        if currentContextConfiguration != configuration {
            try? WCSession.default.updateApplicationContext(dictionary)
        }

        if WCSession.default.isReachable {
            WCSession.default.sendMessage(dictionary, replyHandler: nil, errorHandler: nil)
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
        guard let configuration = controller.session?.configuration else { return }
        guard let dictionary = try? DictionaryEncoder<[String: Any]>().encode(configuration) else { return }
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(dictionary, replyHandler: nil, errorHandler: nil)
        }
    }
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let configuration = try? DictionaryDecoder().decode(MetronomeConfiguration.self, from: message) {
            DispatchQueue.main.async { [weak self] in
                self?.controller.set(configuration: configuration)
            }
        }
    }
}
