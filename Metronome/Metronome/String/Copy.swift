//
//  Copy.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 4/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import Foundation

protocol CopyIdentifier {
    var key: String { get }
}


extension CopyIdentifier where Self: RawRepresentable, Self.RawValue == String {
    var key: String {
        return self.rawValue
    }
}


struct Copy {

    enum TimeSignature: String, CopyIdentifier {
        case barLength = "metronome.time_signature.bar_length.picker.title"
        case noteLength = "metronome.time_signature.note_length.picker.title"
    }

    enum Tempo: String, CopyIdentifier {
        case suffix = "metronome.tempo.suffix"
    }

    enum Action: String, CopyIdentifier {
        case confirm = "action.confirm"
    }

    // MARK: Localisation

    static func localised(with identifier: CopyIdentifier) -> String {
        return NSLocalizedString(identifier.key, comment: "")
    }
}
