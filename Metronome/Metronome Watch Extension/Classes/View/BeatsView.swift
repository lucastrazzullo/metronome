//
//  BeatsView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 6/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct BeatsView: View {

    @ObservedObject var viewModel: BeatsViewModel

    var body: some View {
        HStack {
            ForEach(viewModel.beats, id: \.id) { beatViewModel in
                BeatView(viewModel: beatViewModel)
            }
        }
    }
}


// MARK: Previews

struct BeatsView_Preview: PreviewProvider {

    static var previews: some View {
        let barLength = TimeSignature.BarLength(numberOfBeats: TimeSignature.BarLength.range.upperBound, accentPositions: [0, 2, 4])
        let timeSignature = TimeSignature(barLength: barLength, noteLength: .default)
        let configuration = MetronomeConfiguration(timeSignature: timeSignature, tempo: .default)
        let metronome = Metronome(with: configuration, soundOn: false)

        let publisher = MetronomePublisher(metronome: metronome)
        publisher.isRunning = true
        publisher.currentBeat = Beat(position: 0, isAccent: true)

        let viewModel = BeatsViewModel(metronomePublisher: publisher)
        return BeatsView(viewModel: viewModel)
    }
}
