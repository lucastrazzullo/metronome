//
//  ChromeViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 17/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct ChromeViewModel {

    // MARK: Getters

    private(set) var timeSignatureLabel: String
    private(set) var tempoLabel: String


    // MARK: Object life cycle

    init(configuration: MetronomeConfiguration) {
        self.timeSignatureLabel = ChromeViewModel.timeSignatureLabel(with: configuration.timeSignature)
        self.tempoLabel = ChromeViewModel.tempoLabel(with: configuration.tempo)
    }


    // MARK: Private builder helper methods

    private static func timeSignatureLabel(with timeSignature: TimeSignature) -> String {
        return String(format: NSLocalizedString("metronome.time_signature.format", comment: ""), timeSignature.beats, timeSignature.noteLength.rawValue)
    }


    private static func tempoLabel(with tempo: Tempo) -> String {
        return String(format: "%d%@", tempo.bpm, NSLocalizedString("metronome.tempo.suffix", comment: "").uppercased())
    }
}
