//
//  MetronomeSession.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 18/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class MetronomeSession {

    struct Snapshot: Codable, Equatable {

        enum Owner: Int, Codable {
            case phone
            case watch
        }

        let owner: Owner
        var configuration: MetronomeConfiguration
        var isSoundOn: Bool
        var isRunning: Bool
        var currentBeat: Beat?

        init(owner: Owner, configuration: MetronomeConfiguration, isSoundOn: Bool, isRunning: Bool, currentBeat: Beat?) {
            self.owner = owner
            self.configuration = configuration
            self.isSoundOn = isSoundOn
            self.isRunning = isRunning
            self.currentBeat = currentBeat
        }

        static func with(metronome: Metronome, owner: Owner) -> Snapshot {
            return Snapshot(owner: owner, configuration: metronome.configuration, isSoundOn: metronome.isSoundOn, isRunning: metronome.isRunning, currentBeat: metronome.currentBeat)
        }

        static func `default`(owner: Owner) -> Snapshot {
            return Snapshot(owner: owner, configuration: .default, isSoundOn: false, isRunning: false, currentBeat: nil)
        }
    }


    // MARK: Instance properties

    @Published private(set) var configuration: MetronomeConfiguration
    @Published private(set) var isSoundOn: Bool
    @Published private(set) var isRunning: Bool
    @Published private(set) var currentBeat: Beat?

    private var owner: Snapshot.Owner


    // MARK: Object life cycle

    init(owner: Snapshot.Owner, configuration: MetronomeConfiguration, isSoundOn: Bool, isRunning: Bool, currentBeat: Beat?) {
        self.owner = owner
        self.configuration = configuration
        self.isSoundOn = isSoundOn
        self.isRunning = isRunning
        self.currentBeat = currentBeat
    }


    init(withSnapshot snapshot: Snapshot) {
        self.owner = snapshot.owner
        self.configuration = snapshot.configuration
        self.isSoundOn = snapshot.isSoundOn
        self.isRunning = snapshot.isRunning
        self.currentBeat = snapshot.currentBeat
    }


    // MARK: Update

    func set(configuration: MetronomeConfiguration, owner: Snapshot.Owner) {
        self.owner = owner
        self.configuration = configuration
    }


    func set(isSoundOn: Bool, owner: Snapshot.Owner) {
        self.owner = owner
        self.isSoundOn = isSoundOn
    }


    func set(isRunning: Bool, owner: Snapshot.Owner) {
        self.owner = owner
        self.isRunning = isRunning
    }


    func set(currentBeat: Beat?, owner: Snapshot.Owner) {
        self.owner = owner
        self.currentBeat = currentBeat
    }


    // MARK: Snapshot

    func update(with snapshot: Snapshot) {
        owner = snapshot.owner
        configuration = snapshot.configuration
        isSoundOn = snapshot.isSoundOn
        isRunning = snapshot.isRunning
        currentBeat = snapshot.currentBeat
    }


    func currentSnapshot() -> Snapshot {
        Snapshot(owner: owner, configuration: configuration, isSoundOn: isSoundOn, isRunning: isRunning, currentBeat: currentBeat)
    }


    func snapshotPublisher() -> AnyPublisher<Snapshot, Never> {
        return Publishers.CombineLatest4($configuration, $isSoundOn, $isRunning, $currentBeat)
            .map({ Snapshot(owner: self.owner, configuration: $0, isSoundOn: $1, isRunning: $2, currentBeat: $3) })
            .eraseToAnyPublisher()
    }
}
