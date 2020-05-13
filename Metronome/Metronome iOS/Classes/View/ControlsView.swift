//
//  ControlsView.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct ControlsView: View {

    @ObservedObject var viewModel: ControlsViewModel

    var body: some View {
        HStack(alignment: .bottom, spacing: 24) {
            LeftControlsView(viewModel: viewModel)
            Spacer()
            RightControlsView(viewModel: viewModel)
        }
        .padding([.leading, .trailing], 24)
        .padding([.top, .bottom], 10)
    }
}


private struct LeftControlsView: View {

    @ObservedObject private(set) var viewModel: ControlsViewModel

    @State private var showingTempoPicker: Bool = false
    @State private var showingTapTempoPicker: Bool = false
    @State private var showingTimeSignaturePicker: Bool = false

    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            HStack(alignment: .center, spacing: 4) {
                ControlsButton(label: viewModel.tempoLabel, gradient: .yellowGreen, action: {
                    self.showingTempoPicker.toggle()
                })
                .sheet(isPresented: $showingTempoPicker) {
                    TempoPickerView(viewModel: TempoPickerViewModel(metronome: self.viewModel.metronome))
                        .onAppear(perform: { self.viewModel.reset() })
                }

                ControlsButton(label: viewModel.tapTempoLabel, gradient: .greenYellow, action: {
                    self.showingTapTempoPicker.toggle()
                })
                .sheet(isPresented: $showingTapTempoPicker) {
                    TapTempoPickerView(viewModel: TapTempoPickerViewModel(metronome: self.viewModel.metronome))
                        .onAppear(perform: { self.viewModel.reset() })
                }
            }

            HStack(alignment: .center, spacing: 4) {
                ControlsButton(label: Copy.TimeSignature.title.localised, gradient: .orangePink) {
                    self.showingTimeSignaturePicker.toggle()
                }
                .sheet(isPresented: $showingTimeSignaturePicker) {
                    TimeSignaturePickerView(viewModel: TimeSignaturePickerViewModel(metronome: self.viewModel.metronome))
                        .onAppear(perform: { self.viewModel.reset() })
                }

                ControlsButton(label: viewModel.timeSignatureLabel, gradient: .pinkOrange) {
                    self.showingTimeSignaturePicker.toggle()
                }
                .sheet(isPresented: $showingTimeSignaturePicker) {
                    TimeSignaturePickerView(viewModel: TimeSignaturePickerViewModel(metronome: self.viewModel.metronome))
                        .onAppear(perform: { self.viewModel.reset() })
                }
            }
        }
    }
}


private struct RightControlsView: View {

    @ObservedObject private(set) var viewModel: ControlsViewModel

    var body: some View {
        ControlsButton(icon: viewModel.soundTogglerIcon, gradient: .blueGreen, action: {
            self.viewModel.toggleSoundOn()
        })
    }
}


private struct ControlsButton: View {

    struct ButtonContent: View {

        private(set) var label: String?
        private(set) var icon: SystemIcon?

        var body: some View {
            if let label = self.label, let icon = icon {
                return AnyView(HStack(alignment: .center, spacing: 4) {
                    Image(systemName: icon.name)
                    Text(label)
                })
            } else if let label = self.label {
                return AnyView(Text(label))
            } else if let icon = self.icon {
                return AnyView(Image(systemName: icon.name))
            } else {
                return AnyView(EmptyView())
            }
        }
    }


    // MARK: Instance properties

    private(set) var label: String?
    private(set) var icon: SystemIcon?
    private(set) var gradient: Palette.Gradients
    private(set) var action: () -> ()

    var body: some View {
        Button(action: action) {
            ZStack {
                LinearGradient(gradient)
                    .cornerRadius(8)

                ButtonContent(label: label, icon: icon)
                    .brandFont(.callout)
                    .padding(12)
                    .foregroundColor(Palette.white.color)
            }
            .frame(minHeight: 44, idealHeight: 44, maxHeight: 44, alignment: .center)
            .fixedSize()
        }
    }
}
