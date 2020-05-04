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

    var localised: String {
        return NSLocalizedString(key, comment: "")
    }
}


struct Copy {

    enum Tempo: String, CopyIdentifier {
        case suffix = "metronome.tempo.suffix"

        enum Picker: String, CopyIdentifier {
            case title = "metronome.tempo.picker.title"
        }
    }

    enum TimeSignature: String, CopyIdentifier {
        case barLength = "metronome.time_signature.bar_length.picker.title"
        case noteLength = "metronome.time_signature.note_length.picker.title"

        enum Picker: String, CopyIdentifier {
            case title = "metronome.time_signature.picker.title"
        }
    }

    enum Action: String, CopyIdentifier {
        case confirm = "action.confirm"
    }
}
