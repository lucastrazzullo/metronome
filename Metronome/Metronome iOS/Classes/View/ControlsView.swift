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
        .padding([.leading, .trailing, .bottom], 24)
        .padding([.top], 12)
    }
}


private struct ControlsButton<Content>: View where Content: View {

    private(set) var highlighted: Bool
    private(set) var background: ShapeIllustration
    private(set) var action: () -> ()
    private(set) var content: () -> Content

    var body: some View {
        Button(action: action) {
            ZStack {
                Image(background)
                    .resizable()
                    .renderingMode(highlighted ? .original : .template)
                    .foregroundColor(Palette.gray.color)
                    .animation(.default)

                content()
                    .brandFont(.headline)
                    .padding(12)
                    .foregroundColor(highlighted ? Palette.white.color : Palette.white.color.opacity(0.29))
            }
            .frame(minHeight: 44, idealHeight: 44, maxHeight: 44, alignment: .center)
            .fixedSize()
        }
    }
}


// MARK: Concrete Views

private struct TempoButton: View {

    @ObservedObject var viewModel: ControlsViewModel

    @State private var showingPicker: Bool = false

    var body: some View {
        ControlsButton(highlighted: !viewModel.metronomeIsRunning, background: .button1, action: {
            self.showingPicker.toggle()
        }) {
            Text(self.viewModel.tempoLabel)
        }
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
        ControlsButton(highlighted: !viewModel.metronomeIsRunning, background: .button2, action: {
            self.showingPicker.toggle()
        }) {
            ZStack {
                GeometryReader { geometry in
                    Circle()
                        .frame(width: 8, height: 8, alignment: .center)
                        .position(x: geometry.size.width - 8, y: 2)
                        .foregroundColor(self.viewModel.tapTempoIndicatorIsHighlighted ? Palette.green.color : Palette.white.color)
                }

                Text(self.viewModel.tapTempoLabel)
            }
        }
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
        ControlsButton(highlighted: !viewModel.metronomeIsRunning, background: .button4, action: {
            self.showingPicker.toggle()
        }) {
            Text(self.viewModel.timeSignatureLabel)
        }
        .sheet(isPresented: $showingPicker) {
            TimeSignaturePickerView(viewModel: TimeSignaturePickerViewModel(controller: self.viewModel.controller))
                .onAppear(perform: { self.viewModel.reset() })
        }
    }
}


private struct SoundTogglerButton: View {

    @ObservedObject var viewModel: ControlsViewModel

    var body: some View {
        ControlsButton(highlighted: viewModel.metronomeSoundIsOn, background: .button5, action: viewModel.toggleSoundOn) {
            Image(self.viewModel.soundTogglerIcon)
        }
    }
}


private struct RunningTogglerButton: View {

    @ObservedObject var viewModel: ControlsViewModel

    var body: some View {
        ControlsButton(highlighted: !viewModel.metronomeIsRunning, background: .button6, action: viewModel.toggleIsRunning) {
            Text(self.viewModel.metronomeTogglerLabel)
        }
    }
}
