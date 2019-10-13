//
//  TimeSignatureUpdaterViewModel.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct TimeSignatureUpdaterViewModel {

    var timeSignature: TimeSignature


    // MARK: Getters

    var timeSignatureLabel: String {
        return String(format: NSLocalizedString("metronome.time_signature.format", comment: ""), timeSignature.bits, timeSignature.noteLength.rawValue)
    }
}
