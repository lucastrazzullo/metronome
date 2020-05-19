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
                NavigationLink(destination: timeSignaturePickerView()) {
                    Text(viewModel.timeSignatureLabel).font(Font.system(.footnote))
                }
                .buttonStyle(ControlsButtonStyle(highlighted: !viewModel.metronomeIsRunning, background: .button1))

                NavigationLink(destination: tempoPickerView()) {
                    Text(viewModel.tempoLabel).font(Font.system(.footnote))
                }
                .buttonStyle(ControlsButtonStyle(highlighted: !viewModel.metronomeIsRunning, background: .button3))
            }

            HStack(alignment: .center, spacing: 24) {
                Spacer()
                Button(action: viewModel.toggleIsRunning) {
                    Text(viewModel.metronomeTogglerLabel)
                }
                .buttonStyle(ControlsButtonStyle(highlighted: !viewModel.metronomeIsRunning, background: .button5))
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


private struct ControlsButtonStyle: ButtonStyle {

    private(set) var highlighted: Bool
    private(set) var background: ShapeIllustration

    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            Image(background)
                .resizable()
                .renderingMode(highlighted ? .original : .template)
                .foregroundColor(Palette.gray.color)
                .animation(.default)

            configuration.label
                .foregroundColor(.white)
                .padding(8)
        }
        .frame(minHeight: 46)
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
