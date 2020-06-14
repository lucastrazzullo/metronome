//
//  TapTempoPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 14/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation
import Combine

class TapTempoPickerViewModel: ObservableObject {

    @Published private(set) var selectedTempoBpm: Int?

    var isAutomaticCommitActive: Bool = false

    private let controller: SessionController

    private var tapTimestamps: [TimeInterval] = []
    private var cancellables: Set<AnyCancellable> = []


    // MARK: Object life cycle

    init(controller: SessionController) {
        self.controller = controller

        self.$selectedTempoBpm
            .debounce(for: 0.8, scheduler: DispatchQueue.main)
            .filter({ [weak self] _ in self?.isAutomaticCommitActive ?? false })
            .sink(receiveValue: { [weak self] _ in self?.commit() })
            .store(in: &cancellables)
    }


    // MARK: Public methods

    func update(with timestamp: TimeInterval) {
        if let frequency = getFrequency(withNew: timestamp) {
            selectedTempoBpm = controller.session?.configuration.getBpm(with: frequency)
        }
    }


    func commit() {
        if let bpm = selectedTempoBpm {
            controller.set(tempoBpm: bpm)
        }
    }


    // MARK: Private helper methods

    private func getFrequency(withNew timestamp: TimeInterval) -> TimeInterval? {
        tapTimestamps.append(timestamp)
        if tapTimestamps.count > 5 {
            tapTimestamps.remove(at: 0)
        }
        return getFrequency()
    }


    private func getFrequency() -> TimeInterval? {
        guard tapTimestamps.count >= 2 else { return nil }
        let frequencies: [Double] = tapTimestamps.enumerated().compactMap { index, timestamp in
            if index + 1 == tapTimestamps.count {
                return nil
            } else {
                return tapTimestamps[index + 1] - timestamp
            }
        }
        return frequencies.reduce(0, +) / Double(frequencies.count)
    }
}
