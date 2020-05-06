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
                }.foregroundColor(Color.white).opacity(0.7)
            }.frame(width: nil, height: 40, alignment: .center)
        }.padding([.leading, .trailing], 24).padding([.top, .bottom], 10)
    }
}


private struct LeftControlsView: View {

    @ObservedObject private(set) var viewModel: ControlsViewModel

    @State private var showingTempoPicker: Bool = false
    @State private var showingTimeSignaturePicker: Bool = false

    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            ControlsButton(label: viewModel.tempoLabel ?? "", background: Palette.yellow.color, action: { self.showingTempoPicker.toggle() })
                .sheet(isPresented: $showingTempoPicker) {
                    TempoPickerView(viewModel: self.viewModel.tempoPickerViewModel())
                        .onAppear(perform: { self.viewModel.reset() })
                }

            ControlsButton(label: viewModel.timeSignatureLabel ?? "", background: Palette.orange.color, action: { self.showingTimeSignaturePicker.toggle() })
                .sheet(isPresented: $showingTimeSignaturePicker) {
                    TimeSignaturePickerView(viewModel: self.viewModel.timeSignaturePickerViewModel())
                        .onAppear(perform: { self.viewModel.reset() })
                }
        }
    }
}


private struct RightControlsView: View {

    @ObservedObject private(set) var viewModel: ControlsViewModel

    @State private var showingHelpView: Bool = false

    var body: some View {
        ControlsButton(label: Copy.Controls.help.localised, background: Color.white.opacity(0.4), action: { self.showingHelpView.toggle() })
            .sheet(isPresented: $showingHelpView) {
                TipsView(viewModel: TipsViewModel(tips: TipsViewModelRepository.all))
                    .onAppear(perform: { self.viewModel.reset() })
            }
    }
}


private struct ControlsButton: View {

    private(set) var label: String
    private(set) var background: Color
    private(set) var action: () -> ()

    var body: some View {
        Button(action: action, label: { Text(label).brandFont(.footnote) })
            .padding(8)
            .background(background)
            .cornerRadius(8)
    }
}
