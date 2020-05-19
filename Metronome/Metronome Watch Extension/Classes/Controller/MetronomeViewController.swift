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

class MetronomeViewController: WKHostingController<MetronomeView> {

    override var body: MetronomeView {
        return MetronomeView(viewModel: metronomeViewModel)
    }

    private let metronome: Metronome
    private let metronomePublisher: MetronomePublisher
    private var metronomeViewModel: MetronomeViewModel

    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    override init() {
        metronome = Metronome(with: .default, soundOn: false)
        metronomePublisher = MetronomePublisher(metronome: metronome)
        metronomeViewModel = MetronomeViewModel(metronomePublisher: metronomePublisher)
        super.init()
    }


    // MARK: Interface life cycle

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        cancellables.append(metronomePublisher.$isRunning.sink { isRunning in
            if isRunning {
                WKInterfaceDevice.current().play(WKHapticType.start)
            } else {
                WKInterfaceDevice.current().play(WKHapticType.stop)
            }
        })

        cancellables.append(metronomePublisher.$currentBeat.sink { beat in
            guard let beat = beat else { return }
            if beat.isAccent {
                WKInterfaceDevice.current().play(WKHapticType.start)
            } else {
                WKInterfaceDevice.current().play(WKHapticType.directionDown)
            }
        })
    }


    override func didDeactivate() {
        metronome.reset()
        super.didDeactivate()
    }
}
