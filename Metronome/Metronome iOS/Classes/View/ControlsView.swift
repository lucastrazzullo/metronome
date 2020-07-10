//
//  ControlsView.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct ControlsView: View {

    @ObservedObject private(set) var viewModel: ControlsViewModel

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            TempoButton(viewModel: viewModel)
            TempoTapButton(viewModel: viewModel)
            TimeSignatureButton(viewModel: viewModel)
            Spacer()
            SoundTogglerButton(viewModel: viewModel)
            RunningTogglerButton(viewModel: viewModel)
        }
        .brandFont(.headline)
            
        .padding([.leading, .trailing, .bottom], 24)
        .padding([.top], 12)
    }
}


// MARK: Concrete Views

private struct TempoButton: View {

    @ObservedObject var viewModel: ControlsViewModel

    @State private var showingPicker: Bool = false

    var body: some View {
        Button(action: { self.showingPicker.toggle() }) {
            Text(self.viewModel.tempoLabel)
        }
        .buttonStyle(ShapedButtonStyle(highlighted: !viewModel.metronomeIsRunning, shape: .button1))
        .sheet(isPresented: $showingPicker) {
            TempoPickerView(viewModel: TempoPickerViewModel(controller: self.viewModel.controller))
                .onAppear(perform: { self.viewModel.reset() })
        }
    }
}


private struct TempoTapButton: View {

    @ObservedObject var viewModel: ControlsViewModel

    @State private var showingPicker: Bool = false

    var body: some View {
        Button(action: { self.showingPicker.toggle() }) {
            HStack(alignment: .top, spacing: 8) {
                Text(self.viewModel.tapTempoLabel)
                Circle()
                    .frame(width: 8, height: 8, alignment: .center)
                    .foregroundColor(self.viewModel.tapTempoIndicatorIsHighlighted ? Palette.green.color : Palette.white.color)
            }
        }
        .buttonStyle(ShapedButtonStyle(highlighted: !viewModel.metronomeIsRunning, shape: .button2))
        .sheet(isPresented: $showingPicker) {
            TapTempoPickerView(viewModel: TapTempoPickerViewModel(controller: self.viewModel.controller))
                .onAppear(perform: { self.viewModel.reset() })
        }
    }
}


private struct TimeSignatureButton: View {

    @ObservedObject var viewModel: ControlsViewModel

    @State private var showingPicker: Bool = false

    var body: some View {
        Button(action: { self.showingPicker.toggle() }) {
            Text(self.viewModel.timeSignatureLabel)
        }
        .buttonStyle(ShapedButtonStyle(highlighted: !viewModel.metronomeIsRunning, shape: .button4))
        .sheet(isPresented: $showingPicker) {
            TimeSignaturePickerView(viewModel: TimeSignaturePickerViewModel(controller: self.viewModel.controller))
                .onAppear(perform: { self.viewModel.reset() })
        }
    }
}


private struct SoundTogglerButton: View {

    @ObservedObject var viewModel: ControlsViewModel

    var body: some View {
        Button(action: viewModel.toggleSoundOn) {
            Image(self.viewModel.soundTogglerIcon)
                .font(Font.system(.callout).weight(.bold))
                .padding(.vertical, 4)
                .frame(minWidth: 32, idealWidth: 32, maxWidth: 32, alignment: .center)
        }
        .buttonStyle(ShapedButtonStyle(highlighted: viewModel.metronomeSoundIsOn, shape: .button5))
    }
}


private struct RunningTogglerButton: View {

    @ObservedObject var viewModel: ControlsViewModel

    var body: some View {
        Button(action: viewModel.toggleIsRunning) {
            Text(self.viewModel.metronomeTogglerLabel)
                .frame(minWidth: 44, idealWidth: 44, maxWidth: 44, alignment: .center)
        }
        .buttonStyle(ShapedButtonStyle(highlighted: !viewModel.metronomeIsRunning, shape: .button6))
    }
}
