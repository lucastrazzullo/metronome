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

    var body: some View {
        HStack(alignment: .bottom, spacing: 60) {
            Button(action: { self.viewModel.toggleIsRunning() }) { Text(viewModel.toggleLabel ?? "") }
            ConfigurationPickerView(viewModel: viewModel.configurationPickerViewModel())
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
                Picker(selection: self.$viewModel.tempoPickerViewModel.selectedTempoItem,
                   label: Text(Copy.Tempo.unit.localised)) {
                    ForEach(self.viewModel.tempoPickerViewModel.tempoItems, id: \.self) { item in
                        Text(item.label)
                    }
                }
            }
            VStack(alignment: .leading, spacing: nil) {
                Text(Copy.TimeSignature.title.localised)
                HStack {
                    Picker(selection: self.$viewModel.timeSignaturePickerViewModel.selectedBarLength,
                           label: Text(Copy.TimeSignature.barLength.localised)) {
                            ForEach(self.viewModel.timeSignaturePickerViewModel.barLengthItems, id: \.self) { item in
                                Text(item.label)
                            }
                        }
                    Picker(selection: self.$viewModel.timeSignaturePickerViewModel.selectedNoteLength,
                           label: Text(Copy.TimeSignature.noteLength.localised)) {
                            ForEach(self.viewModel.timeSignaturePickerViewModel.noteLengthItems, id: \.self) { item in
                                Text(item.label)
                            }
                        }
                }
            }
            Button(action: { self.viewModel.commit() },
                   label: { Text(Copy.Controls.confirm.localised) })
                .disabled(!viewModel.confirmationEnabled)
        }
    }
}
