//
//  TapTempoPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 14/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class TapTempoPickerViewModel: ObservableObject {

    @Published private(set) var selectedTempoBpm: Int?

    private var tapTimestamps: [TimeInterval]

    private let metronome: Metronome


    // MARK: Object life cycle

    init(metronome: Metronome) {
        self.metronome = metronome
        self.tapTimestamps = []
    }


    // MARK: Public methods

    func update(with timestamp: TimeInterval) {
        if let frequency = getFrequency(withNew: timestamp) {
            selectedTempoBpm = metronome.configuration.getBpm(with: frequency)
        }
    }


    func commit() {
        if let tempo = selectedTempoBpm {
            metronome.configuration.setBpm(tempo)
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
