//
//  MetronomeViewController.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import WatchKit
import SwiftUI

class SessionHostingController: WKHostingController<AnyView> {

    var sessionController: SessionController {
        return (WKExtension.shared().delegate as! ExtensionDelegate).sessionController
    }

    override var body: AnyView {
        let tempoViewModel = TempoPickerViewModel(controller: sessionController)
        tempoViewModel.isAutomaticCommitActive = true

        let timeSignatureViewModel = TimeSignaturePickerViewModel(controller: sessionController)
        timeSignatureViewModel.isAutomaticCommitActive = true

        return AnyView(ControlsView(tempoViewModel: tempoViewModel, timeSignatureViewModel: timeSignatureViewModel))
    }


    // MARK: Interface life cycle

    override func awake(withContext context: Any?) {
        if let context = context as? [String: Any], let configuration = try? DictionaryDecoder().decode(MetronomeConfiguration.self, from: context) {
            sessionController.set(configuration: configuration)
        }
    }


    override func didDeactivate() {
        sessionController.reset()
        super.didDeactivate()
    }
}
