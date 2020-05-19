//
//  MetronomeConfiguration.swift
//  Metronome
//
//  Created by luca strazzullo on 1/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import Foundation

struct MetronomeConfiguration: Equatable {

    var timeSignature: TimeSignature
    var tempo: Tempo


    // MARK: Object life cycle

    static var `default`: MetronomeConfiguration {
        return MetronomeConfiguration(timeSignature: .default, tempo: .default)
    }


    // MARK: Public methods

    func getTimeInterval() -> TimeInterval {
        return Double(60) / Double(tempo.bpm) / (Double(timeSignature.noteLength.rawValue) / Double(4))
    }


    func getBpm(with frequency: TimeInterval) -> Int {
        let standardNoteBpm = 60 / frequency
        let bpm = Int(standardNoteBpm) * 4 / timeSignature.noteLength.rawValue
        return max(Tempo.range.lowerBound, min(Tempo.range.upperBound, bpm))
    }


    mutating func setBpm(_ bpm: Int) {
        tempo = Tempo(bpm: bpm)
    }


    mutating func setAccent(_ isAccent: Bool, onBeatWith position: Int) {
        if position < timeSignature.barLength.numberOfBeats {
            timeSignature.barLength.beats[position].isAccent = isAccent
        }
    }


    mutating func setTimeSignature(_ signature: TimeSignature) {
        timeSignature = signature
    }
}


extension MetronomeConfiguration: Codable {

    enum CodingKeys: String, CodingKey {
        case tempoBpm
        case numberOfBeats
        case accentPositions
        case noteLength
    }


    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let tempoBpm = try values.decode(Int.self, forKey: .tempoBpm)
        let numberOfBeats = try values.decode(Int.self, forKey: .numberOfBeats)
        let noteLengthRaw = try values.decode(Int.self, forKey: .noteLength)
        let accentPositions = try? values.decode([Int].self, forKey: .accentPositions)

        let barLength: TimeSignature.BarLength
        if let accentPositions = accentPositions {
            barLength = TimeSignature.BarLength(numberOfBeats: numberOfBeats, accentPositions: Set(accentPositions))
        } else {
            barLength = TimeSignature.BarLength(numberOfBeats: numberOfBeats)
        }
        let noteLength = TimeSignature.NoteLength(rawValue: noteLengthRaw) ?? .default

        timeSignature = TimeSignature(barLength: barLength, noteLength: noteLength)
        tempo = Tempo(bpm: tempoBpm)
    }


    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(tempo.bpm, forKey: .tempoBpm)
        try container.encode(timeSignature.barLength.numberOfBeats, forKey: .numberOfBeats)
        try container.encode(Array(timeSignature.barLength.accentPositions), forKey: .accentPositions)
        try container.encode(timeSignature.noteLength.rawValue, forKey: .noteLength)
    }
}
