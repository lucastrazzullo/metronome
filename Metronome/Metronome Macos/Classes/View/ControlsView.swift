//
//  ControlsView.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct ControlsView: View {

    @EnvironmentObject var viewModel: MetronomeViewModel

    var body: some View {
        HStack(alignment: .bottom, spacing: nil) {
            Button(action: { self.viewModel.toggleIsRunning() }) {
                Text(viewModel.controlsViewModel.toggleLabel)
            }.padding()
            ConfigurationPickerView(viewModel: ConfigurationPickerViewModel(configuration: viewModel.configuration)) { configuration in
                self.viewModel.set(configuration: configuration)
            }.padding()
        }
    }
}


struct ConfigurationPickerView: View {

    @ObservedObject var viewModel: ConfigurationPickerViewModel

    var completion: ((MetronomeConfiguration) -> ())


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
            Button(action: { self.completion(self.viewModel.selectedConfiguration)},
                   label: { Text(Copy.Controls.confirm.localised) })
                .disabled(!viewModel.confirmationEnabled)
        }
    }
}
