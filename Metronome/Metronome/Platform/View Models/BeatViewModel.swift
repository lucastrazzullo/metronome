//
//  BeatViewModel.swift
//  MetronomeTests
//
//  Created by luca strazzullo on 6/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class BeatViewModel: ObservableObject, Identifiable {

    struct State: OptionSet {

        let rawValue: Int

        static let highlighted = State(rawValue: 1 << 0)
        static let accented = State(rawValue: 1 << 1)


        // MARK: Object life cycle

        init(rawValue: Int) {
            self.rawValue = rawValue
        }


        init(with position: Int, timeSignature: TimeSignature, highlightedBeat: Beat?, isRunning: Bool) {
            self = []
            self.set(highlightedBeat: highlightedBeat, isRunning: isRunning, position: position)
            self.set(timeSignature: timeSignature, position: position)
        }


        // MARK: Public methods

        mutating func set(highlightedBeat: Beat?, isRunning: Bool, position: Int) {
            if isRunning && highlightedBeat?.position == position {
                insert(.highlighted)
            } else {
                remove(.highlighted)
            }
        }


        mutating func set(timeSignature: TimeSignature, position: Int) {
            if position < timeSignature.barLength.numberOfBeats, timeSignature.barLength.beats[position].isAccent {
                insert(.accented)
            } else {
                remove(.accented)
            }
        }


        mutating func set(isAccent: Bool) {
            if isAccent {
                insert(.accented)
            } else {
                remove(.accented)
            }
        }


        mutating func toggleIsAccent() {
            if contains(.accented) {
                remove(.accented)
            } else {
                insert(.accented)
            }
        }
    }


    // MARK: Instance properties

    @Published private(set) var label: String
    @Published private(set) var state: State = []

    let controller: SessionController

    private(set) var position: Int
    private(set) var isTemporaryValueSelected: Bool = false

    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    init(at position: Int, controller: SessionController) {
        self.position = position
        self.label = String(position + 1)
        self.controller = controller
        self.controller.sessionPublisher
            .sink(receiveValue: setupWith(session:))
            .store(in: &cancellables)
    }


    //  MARK: Setup

    private func setupWith(session: MetronomeSession) {
        state = State(with: position, timeSignature: session.configuration.timeSignature, highlightedBeat: session.currentBeat, isRunning: session.isRunning)

        Publishers.CombineLatest(session.$isRunning, session.$currentBeat).sink {
            [weak self, position] isRunning, currentBeat in
            self?.state.set(highlightedBeat: currentBeat, isRunning: isRunning, position: position)
        }
        .store(in: &cancellables)

        session.$configuration.sink {
            [weak self, position] configuration in
            self?.state.set(timeSignature: configuration.timeSignature, position: position)
        }
        .store(in: &cancellables)
    }


    // MARK: Public methods

    func toggleIsAccentTemporarely() {
        state.toggleIsAccent()
        isTemporaryValueSelected = true
    }


    func discard() {
        if isTemporaryValueSelected {
            isTemporaryValueSelected = false
            state.toggleIsAccent()
        }
    }


    func commit() {
        if isTemporaryValueSelected {
            isTemporaryValueSelected = false
            controller.set(isAccent: state.contains(.accented), forBeatAt: position)
        }
    }
}
