//
//  MetronomeView.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct MetronomeView: View {

    private(set) var viewModel: MetronomeViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
//            BeatsView(viewModel: viewModel.beatsViewModel)
//                .frame(height: 24, alignment: .center)
//                .padding(.top, 12)
//                .padding([.leading, .trailing], 4)

            ControlsView(viewModel: viewModel.controlsViewModel)
        }
    }
}


struct MetronomeView_2_Previews: PreviewProvider {

    static var previews: some View {
        let barLength = TimeSignature.BarLength(numberOfBeats: 2)
        let timeSignature = TimeSignature(barLength: barLength, noteLength: .default)
        let configuration = MetronomeConfiguration(timeSignature: timeSignature, tempo: .default)
        let metronome = Metronome(with: configuration, soundOn: false)

        let publisher = MetronomePublisher(metronome: metronome)
        publisher.isRunning = true
        publisher.currentBeat = Beat(position: 0, isAccent: true)

        let viewModel = MetronomeViewModel(metronomePublisher: publisher)
        return MetronomeView(viewModel: viewModel)
    }
}


struct MetronomeView_4_Previews: PreviewProvider {

    static var previews: some View {
        let barLength = TimeSignature.BarLength(numberOfBeats: 4)
        let timeSignature = TimeSignature(barLength: barLength, noteLength: .default)
        let configuration = MetronomeConfiguration(timeSignature: timeSignature, tempo: .default)
        let metronome = Metronome(with: configuration, soundOn: false)

        let publisher = MetronomePublisher(metronome: metronome)
        publisher.isRunning = true
        publisher.currentBeat = Beat(position: 0, isAccent: true)

        let viewModel = MetronomeViewModel(metronomePublisher: publisher)
        return MetronomeView(viewModel: viewModel)
    }
}


struct MetronomeView_8_Previews: PreviewProvider {

    static var previews: some View {
        let barLength = TimeSignature.BarLength(numberOfBeats: TimeSignature.BarLength.range.upperBound, accentPositions: [0, 2, 4])
        let timeSignature = TimeSignature(barLength: barLength, noteLength: .default)
        let configuration = MetronomeConfiguration(timeSignature: timeSignature, tempo: .default)
        let metronome = Metronome(with: configuration, soundOn: false)

        let publisher = MetronomePublisher(metronome: metronome)
        publisher.isRunning = true
        publisher.currentBeat = Beat(position: 0, isAccent: true)

        let viewModel = MetronomeViewModel(metronomePublisher: publisher)
        return MetronomeView(viewModel: viewModel)
    }
}
