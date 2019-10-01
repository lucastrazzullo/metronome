//
//  MetronomeViewController.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class MetronomeViewController: UIHostingController<MetronomeView> {

    private let metronome: Metronome


    // MARK: Object life cycle

    init() {
        metronome = Metronome()
        super.init(rootView: MetronomeView(bpm: metronome.tempo.bpm))
    }


    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: View life cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        metronome.delegate = self
        metronome.statusDelegate = self

        rootView.toggleAction = toggle
    }


    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        metronome.reset()
        metronome.delegate = nil
        metronome.statusDelegate = nil

        rootView.toggleAction = nil
    }


    // MARK: UI Callbacks

    private func toggle() {
        if metronome.isRunning {
            metronome.reset()
        } else {
            metronome.start()
        }
    }
}


extension MetronomeViewController: MetronomeDelegate {

    func metronome(_ metronome: Metronome, didTick bit: Int) {
        rootView.currentBit = bit
    }
}


extension MetronomeViewController: MetronomeStatusDelegate {

    func metronomeDidStart(_ metronome: Metronome) {
        rootView.isRunning = true
    }


    func metronomeDidReset(_ metronome: Metronome) {
        rootView.isRunning = false
        rootView.currentBit = nil
    }
}
