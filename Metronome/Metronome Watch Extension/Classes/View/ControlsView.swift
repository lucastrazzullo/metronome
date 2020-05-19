//
//  ControlsView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 6/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct ControlsView: View {

    @ObservedObject private(set) var viewModel: ControlsViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack(alignment: .center, spacing: 8) {
                NavigationLink(destination: tempoPickerView()) {
                    Text(viewModel.tempoLabel)
                }
                .buttonStyle(MetronomeButtonStyle(highlighted: !viewModel.metronomeIsRunning, background: .button3))

                NavigationLink(destination: timeSignaturePickerView()) {
                    Text(viewModel.timeSignatureLabel)
                }
                .buttonStyle(MetronomeButtonStyle(highlighted: !viewModel.metronomeIsRunning, background: .button4))
            }

            HStack(alignment: .center, spacing: 24) {
                Spacer()
                Button(action: viewModel.toggleIsRunning) {
                    Text(viewModel.metronomeTogglerLabel)
                }
                .buttonStyle(MetronomeButtonStyle(highlighted: !viewModel.metronomeIsRunning, background: .button6))
                Spacer()
            }
        }
    }


    // MARK: Private helper methods

    private func timeSignaturePickerView() -> some View {
        let viewModel = TimeSignaturePickerViewModel(metronome: self.viewModel.metronome)
        return TimeSignaturePickerView(viewModel: viewModel)
    }


    private func tempoPickerView() -> some View {
        let viewModel = TempoPickerViewModel(metronome: self.viewModel.metronome)
        return TempoPickerView(viewModel: viewModel)
    }
}


// MARK: Previews

struct ControlsView_Previews: PreviewProvider {

    static var previews: some View {
        let configuration = MetronomeConfiguration(timeSignature: .default, tempo: .default)
        let metronome = Metronome(with: configuration, soundOn: false)
        let publisher = MetronomePublisher(metronome: metronome)
        let viewModel = ControlsViewModel(with: publisher)
        return ControlsView(viewModel: viewModel)
    }
}
