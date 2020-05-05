//
//  TapTempoPickerViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 14/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

class TapTempoPickerViewModel: GesturePickerViewModel {

    @Published private(set) var selectedTempoBpm: Int?
    private var tapTimestamps: [TimeInterval] = []


    // MARK: Object life cycle

    init() {
        let value = Copy.Picker.TapTempo.valuePlaceholder.localised
        let background = Palette.green
        let title = Copy.Picker.TapTempo.title.localised
        let suffix = Copy.Tempo.unit.localised
        super.init(value: value, background: background, title: title, prefix: nil, suffix: suffix)
    }


    // MARK: Public methods

    func apply(newTapWith timestamp: TimeInterval) {
        if let frequency = getFrequency() {
            selectedTempoBpm = Int(frequency)
            heroLabel = String(frequency)
        } else {
            selectedTempoBpm = nil
            heroLabel = Copy.Picker.TapTempo.valuePlaceholder.localised
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
