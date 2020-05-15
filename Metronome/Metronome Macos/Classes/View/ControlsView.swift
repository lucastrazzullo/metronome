//
//  ControlsView.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct ControlsView: View {

    @ObservedObject private(set) var viewModel: ControlsViewModel

    private(set) var metronome: Metronome

    var body: some View {
        HStack(alignment: .bottom, spacing: 60) {
            Button(action: { self.viewModel.toggleIsRunning() }) { Text(viewModel.metronomeTogglerLabel) }
            ConfigurationPickerView(viewModel: ConfigurationPickerViewModel(metronome: metronome))
        }.padding()
    }
}


private struct ConfigurationPickerView: View {

    @ObservedObject var viewModel: ConfigurationPickerViewModel


    // MARK: Body

    var body: some View {
        HStack(alignment: .bottom, spacing: 48) {
            VStack(alignment: .leading, spacing: nil) {
                Text(Copy.Tempo.title.localised)
            }
            VStack(alignment: .leading, spacing: nil) {
                Text(Copy.TimeSignature.title.localised)
            }
            Button(action: { self.viewModel.commit() },
                   label: { Text(Copy.Controls.confirm.localised) })
                .disabled(!viewModel.confirmationEnabled)
        }
    }
}
