//
//  MetronomeViewController.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import WatchKit
import SwiftUI
import Combine
import WatchConnectivity

class MetronomeHostingController: WKHostingController<MetronomeView> {

    override var body: MetronomeView {
        return MetronomeView(viewModel: metronomeViewModel)
    }

    private let metronomeController: MetronomeController
    private let metronomeViewModel: MetronomeViewModel

    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    override init() {
        metronomeController = DummyMetronomeController()
        metronomeViewModel = MetronomeViewModel(metronomeController: metronomeController)
        super.init()
    }


    // MARK: Interface life cycle

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
        cancellables.append(metronomeController.session.$configuration.sink { configuration in
            if let receivedContextConfiguration = try? UserInfoDecoder<[String: Any]>().decode(MetronomeConfiguration.self, from: WCSession.default.receivedApplicationContext), receivedContextConfiguration == configuration {
                return
            }

            guard let userInfo = try? UserInfoEncoder<[String: Any]>().encode(configuration) else { return }
            guard WCSession.default.isCompanionAppInstalled else { return }
            if WCSession.default.isReachable {
                WCSession.default.sendMessage(userInfo, replyHandler: nil, errorHandler: nil)
            }
        })

        cancellables.append(metronomeController.session.$isRunning.sink { isRunning in
            if isRunning {
                WKInterfaceDevice.current().play(WKHapticType.start)
            } else {
                WKInterfaceDevice.current().play(WKHapticType.stop)
            }
        })

        cancellables.append(metronomeController.session.$currentBeat.sink { beat in
            guard let beat = beat else { return }
            if beat.isAccent {
                WKInterfaceDevice.current().play(WKHapticType.start)
            } else {
                WKInterfaceDevice.current().play(WKHapticType.directionDown)
            }
        })
    }


    override func didDeactivate() {
        metronomeController.reset()
        super.didDeactivate()
    }
    
    
    // MARK: Public methods
    
    func setupMetronome(with configuration: MetronomeConfiguration) {
        metronomeController.set(configuration: configuration)
    }
}


extension MetronomeHostingController: WCSessionDelegate {

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }


    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let configuration = try? UserInfoDecoder().decode(MetronomeConfiguration.self, from: message) {
            DispatchQueue.main.async { [weak self] in
                self?.setupMetronome(with: configuration)
            }
        }
    }
    

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let configuration = try? UserInfoDecoder().decode(MetronomeConfiguration.self, from: applicationContext) {
            DispatchQueue.main.async { [weak self] in
                self?.setupMetronome(with: configuration)
            }
        }
    }
}
