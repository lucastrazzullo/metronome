//
//  ChromeView.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 13/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct ChromeView: View {

    @ObservedObject var viewModel: ControlsViewModel

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                HStack(alignment: .center, spacing: 24) {
                    LeftControlsView(viewModel: viewModel)
                    Spacer()
                    RightControlsView(viewModel: viewModel)
                }
            }
            .frame(width: nil, height: 40, alignment: .center)
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
            ControlsButton(label: viewModel.timeSignatureLabel, background: viewModel.timeSignatureColor.color, action: {
                self.showingTimeSignaturePicker.toggle()
            })
            .sheet(isPresented: $showingTimeSignaturePicker) {
                TimeSignaturePickerView(viewModel: self.viewModel.timeSignaturePickerViewModel())
                    .onAppear(perform: { self.viewModel.reset() })
            }

            ControlsButton(label: viewModel.tempoLabel, background: viewModel.tempoColor.color, action: {
                self.showingTempoPicker.toggle()
            })
            .sheet(isPresented: $showingTempoPicker) {
                TempoPickerView(viewModel: self.viewModel.tempoPickerViewModel())
                    .onAppear(perform: { self.viewModel.reset() })
            }

            ControlsButton(label: viewModel.tapTempoLabel, background: viewModel.tapTempoColor.color, action: {
                self.showingTapTempoPicker.toggle()
            })
            .sheet(isPresented: $showingTapTempoPicker) {
                TapTempoPickerView(viewModel: self.viewModel.tapTempoPickerViewModel())
                    .onAppear(perform: { self.viewModel.reset() })
            }

            ControlsButton(icon: viewModel.soundTogglerIcon, background: viewModel.soundTogglerColor.color, action: {
                self.viewModel.toggleSoundOn()
            })
        }
    }
}


private struct RightControlsView: View {

    @ObservedObject private(set) var viewModel: ControlsViewModel

    @State private var showingHelpView: Bool = false

    var body: some View {
        ControlsButton(label: Copy.Controls.tips.localised, background: Color.white.opacity(0.4), action: {
            self.showingHelpView.toggle()
        })
        .sheet(isPresented: $showingHelpView) {
            TipsView(viewModel: TipsViewModel(tips: TipsViewModelRepository.all))
                .onAppear(perform: { self.viewModel.reset() })
        }
    }
}


private struct ControlsButton: View {

    private(set) var label: String?
    private(set) var icon: SystemIcon?
    private(set) var background: Color
    private(set) var action: () -> ()

    var body: some View {
        Button(action: action, label: buildButtonLabel)
            .brandFont(.footnote)
            .padding(8)
            .background(background)
            .foregroundColor(Palette.black.color)
            .cornerRadius(8)
    }


    // MARK: Object life cycle

    init(label: String? = nil, icon: SystemIcon? = nil, background: Color, action: @escaping () -> ()) {
        self.label = label
        self.icon = icon
        self.background = background
        self.action = action
    }


    // MARK: Private helper methods

    private func buildButtonLabel() -> AnyView {
        if let label = self.label, let icon = icon {
            return AnyView(HStack(alignment: .center, spacing: 4) {
                Image(systemName: icon.name)
                Text(label)
            })
        } else if let label = self.label {
            return AnyView(Text(label).brandFont(.footnote))
        } else if let icon = self.icon {
            return AnyView(Image(systemName: icon.name))
        } else {
            return AnyView(EmptyView())
        }
    }
}
