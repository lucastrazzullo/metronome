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

    private let metronome: Metronome
    private let metronomePublisher: MetronomeStatePublisher

    private var rootView: MetronomeView
    private var rootViewModel: MetronomeViewModel

    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    override init() {
        let configuration = MetronomeConfiguration(timeSignature: TimeSignature.default, tempo: Tempo.default)
        metronome = Metronome(with: configuration)
        metronomePublisher = MetronomeStatePublisher(metronome: metronome)
        rootViewModel = MetronomeViewModel(snapshot: metronomePublisher.snapshot())
        rootView = MetronomeView(model: rootViewModel, metronome: metronome)
        super.init()
    }


    // MARK: Interface life cycle

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        cancellables.append(
            metronomePublisher.$isRunning.sink { isRunning in
                if isRunning {
                    WKInterfaceDevice.current().play(WKHapticType.click)
                    WKExtension.shared().isAutorotating = true
                } else {
                    WKInterfaceDevice.current().play(WKHapticType.stop)
                    WKExtension.shared().isAutorotating = false
                }
            }
        )

        cancellables.append(
            metronomePublisher.$currentBeat.sink { beat in
                guard let beat = beat else { return }
                switch beat.intensity {
                case .normal:
                    WKInterfaceDevice.current().play(WKHapticType.click)
                case .strong:
                    WKInterfaceDevice.current().play(WKHapticType.start)
                }
            }
        )

        cancellables.append(
            metronomePublisher.snapshotPublisher()
                .sink { [weak self] snapshot in
                    self?.rootViewModel.setSnapshot(snapshot)
                }
        )
    }


    override func didDeactivate() {
        metronome.reset()
        super.didDeactivate()
    }


    // MARK: View

    override var body: MetronomeView {
        return rootView
    }
}
