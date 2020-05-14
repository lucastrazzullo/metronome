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

    enum App: String, CopyIdentifier {
        case title = "metronome.title"
    }

    enum Tempo: String, CopyIdentifier {
        case title = "metronome.tempo.title"
        case unit = "metronome.tempo.unit"
    }

    enum TimeSignature: String, CopyIdentifier {
        case title = "metronome.time_signature.title"
        case format = "metronome.time_signature.representation.format"

        case barLength = "metronome.time_signature.bar_length.title"
        case barLengthSuffixFormat = "metronome.time_signature.bar_length.suffix.format"

        case noteLength = "metronome.time_signature.note_length.title"
        case noteLengthPrefixFormat = "metronome.time_signature.note_length.prefix.format"

        enum Beat: String, CopyIdentifier {
            case accent = "metronome.time_signature.beat.accent"
        }
    }

    enum Controls: String, CopyIdentifier {
        case confirm = "controls.confirm"
        case done = "controls.done"
        case start = "controls.start"
        case stop = "controls.stop"
        case tips = "controls.tips"
        case tapTempo = "controls.tap_tempo"
        case soundOn = "controls.sound_on"
        case soundOff = "controls.sound_off"
        case placeholderValue = "controls.placeholder"
    }

    enum Picker {
        enum TapTempo: String, CopyIdentifier {
            case title = "metronome.picker.tap_tempo.title"
            case valuePlaceholder = "metronome.picker.tap_tempo.value.placeholder"
        }
    }

    enum Welcome: String, CopyIdentifier {
        case title = "welcome.title"
    }

    enum Tips: String, CopyIdentifier {
        case title = "tips.title"

        case swipeUpTitle = "tips.swipeUp.title"
        case swipeUpDescription = "tips.swipeUp.description"

        case toggleTitle = "tips.toggle.title"
        case toggleDescription = "tips.toggle.description"

        case verticalSlideTitle = "tips.vertical_slide.title"
        case verticalSlideDescription = "tips.vertical_slide.description"

        case horizontalSlideTitle = "tips.horizontal_slide.title"
        case horizontalSlideDescription = "tips.horizontal_slide.description"

        case pinchTitle = "tips.pinch.title"
        case pinchDescription = "tips.pinch.description"

        case longPressTitle = "tips.long_press.title"
        case longPressDescription = "tips.long_press.description"
    }
}
