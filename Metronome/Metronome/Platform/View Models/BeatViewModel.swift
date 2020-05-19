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


        mutating func toggleIsAccent() -> Bool {
            if contains(.accented) {
                remove(.accented)
                return false
            } else {
                insert(.accented)
                return true
            }
        }
    }


    // MARK: Public getters

    var isTemporaryValueSelected: Bool {
        return temporaryIsAccent != nil
    }


    // MARK: Instance properties

    @Published private(set) var label: String
    @Published private(set) var state: State

    private let metronome: Metronome
    private let position: Int

    private var temporaryIsAccent: Bool?
    private var cancellables: [AnyCancellable] = []


    // MARK: Object life cycle

    init(at position: Int, metronomePublisher: MetronomePublisher) {
        self.metronome = metronomePublisher.metronome
        self.position = position
        self.label = String(position + 1)
        self.state = State(with: position, timeSignature: metronomePublisher.configuration.timeSignature, highlightedBeat: metronomePublisher.currentBeat, isRunning: metronomePublisher.isRunning)

        self.cancellables.append(Publishers.CombineLatest(metronomePublisher.$isRunning, metronomePublisher.$currentBeat).sink {
            [weak self] isRunning, currentBeat in
            self?.state.set(highlightedBeat: currentBeat, isRunning: isRunning, position: position)
        })

        self.cancellables.append(metronomePublisher.$configuration.sink {
            [weak self] configuration in
            self?.state.set(timeSignature: configuration.timeSignature, position: position)
        })
    }


    // MARK: Public methods

    func toggleIsAccentTemporarely() {
        temporaryIsAccent = state.toggleIsAccent()
    }


    func discard() {
        if let temporaryIsAccent = temporaryIsAccent {
            state.set(isAccent: !temporaryIsAccent)
            self.temporaryIsAccent = nil
        }
    }


    func commit() {
        if let temporaryIsAccent = temporaryIsAccent {
            metronome.configuration.setAccent(temporaryIsAccent, onBeatWith: position)
            self.temporaryIsAccent = nil
        }
    }
}
