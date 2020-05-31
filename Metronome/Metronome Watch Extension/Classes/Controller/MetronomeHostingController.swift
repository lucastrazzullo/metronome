//
//  MetronomeViewController.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import WatchKit
import SwiftUI

class MetronomeHostingController: WKHostingController<TempoPickerView> {

    override var body: TempoPickerView {
        let viewModel = TempoPickerViewModel(controller: sessionController)
        viewModel.isAutomaticCommitActive = true
        return TempoPickerView(viewModel: viewModel)
    }

    private let sessionController: RemoteSessionController
    private let metronomeViewModel: MetronomeViewModel


    // MARK: Object life cycle

    override init() {
        sessionController = RemoteSessionController()
        metronomeViewModel = MetronomeViewModel(metronomeController: sessionController)
        super.init()
    }


    // MARK: Interface life cycle

    override func didDeactivate() {
        sessionController.reset()
        super.didDeactivate()
    }
    
    
    // MARK: Public methods
    
    func update(with configuration: MetronomeConfiguration) {
        sessionController.set(configuration: configuration)
    }
}
