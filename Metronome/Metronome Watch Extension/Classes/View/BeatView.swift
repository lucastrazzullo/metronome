//
//  BeatView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 19/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct BeatView: View {

    @ObservedObject private(set) var viewModel: BeatViewModel

    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .foregroundColor(self.backgroundColor())

            Circle()
                .stroke(self.accentIndicatorColor(), lineWidth: 2)
        }
    }


    // MARK: Private helper methods

    private func backgroundColor() -> Color {
        if viewModel.state.contains(.highlighted) {
            return Palette.green.color
        } else {
            return Palette.gray.color
        }
    }


    private func foregroundColor() -> Color {
        if viewModel.state.contains(.highlighted) {
            return Palette.white.color
        } else {
            return Palette.gray.color
        }
    }


    private func accentIndicatorColor() -> Color {
        if viewModel.state.contains(.accented) {
            return Palette.purple.color
        } else {
            return .clear
        }
    }
}


// MARK: Previews

struct BeatView_Current_Accented_Preview: PreviewProvider {

    static var previews: some View {
        let metronome = Metronome(with: .default, soundOn: false)
        let publisher = MetronomePublisher(metronome: metronome)
        publisher.isRunning = true
        publisher.currentBeat = Beat(position: 0, isAccent: true)
        let viewModel = BeatViewModel(at: 0, metronomePublisher: publisher)
        return BeatView(viewModel: viewModel)
    }
}


struct BeatView_Current_Preview: PreviewProvider {

    static var previews: some View {
        let metronome = Metronome(with: .default, soundOn: false)
        let publisher = MetronomePublisher(metronome: metronome)
        publisher.isRunning = true
        publisher.currentBeat = Beat(position: 1, isAccent: true)
        let viewModel = BeatViewModel(at: 1, metronomePublisher: publisher)
        return BeatView(viewModel: viewModel)
    }
}


struct BeatView_Accented_Preview: PreviewProvider {

    static var previews: some View {
        let metronome = Metronome(with: .default, soundOn: false)
        let publisher = MetronomePublisher(metronome: metronome)
        publisher.currentBeat = Beat(position: 0, isAccent: true)
        let viewModel = BeatViewModel(at: 0, metronomePublisher: publisher)
        return BeatView(viewModel: viewModel)
    }
}


struct BeatView_Preview: PreviewProvider {

    static var previews: some View {
        let metronome = Metronome(with: .default, soundOn: false)
        let publisher = MetronomePublisher(metronome: metronome)
        let viewModel = BeatViewModel(at: 1, metronomePublisher: publisher)
        return BeatView(viewModel: viewModel)
    }
}
