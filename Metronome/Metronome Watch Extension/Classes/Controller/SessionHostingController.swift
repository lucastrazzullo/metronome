//
//  MetronomeViewController.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import WatchKit
import SwiftUI

class SessionHostingController: WKHostingController<RemoteSessionView> {

    var sessionController: RemoteSessionController {
        return (WKExtension.shared().delegate as! ExtensionDelegate).sessionController
    }

    override var body: RemoteSessionView {
        return RemoteSessionView(viewModel: RemoteSessionViewModel(controller: sessionController))
    }


    // MARK: Interface life cycle

    override func awake(withContext context: Any?) {
        if let context = context as? [String: Any],
            let snapshot = try? DictionaryDecoder().decode(MetronomeSession.Snapshot.self, from: context),
            snapshot.owner == .phone {
            sessionController.set(snapshot: snapshot)
        }
    }
}
