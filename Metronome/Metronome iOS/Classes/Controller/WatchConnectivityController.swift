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

class WatchConnectivityController: MetronomeController {

    private var cancellable: AnyCancellable?


    // MARK: Public methods

    func set(publisher: MetronomePublisher) {
        cancellable = publisher.$configuration.sink { configuration in
            guard let userInfo = try? UserInfoEncoder<[String: Any]>().encode(configuration) else { return }

            let session = WCSession.default
            let transfers = session.remainingComplicationUserInfoTransfers

            switch transfers {
            case 0:
                session.transferCurrentComplicationUserInfo(userInfo)
            case 1...10:
                break
            default:
                session.transferCurrentComplicationUserInfo(userInfo)
            }
        }
    }
}
