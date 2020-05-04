//
//  MetronomeView.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct MetronomeView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: MetronomeViewModel


    // MARK: Body

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 12) {
                Spacer()
                HStack(alignment: .center, spacing: 1) {
                    ForEach(viewModel.beatViewModels, id: \.self) { beatViewModel in
                        BeatView(model: beatViewModel)
                    }
                }
                HStack(alignment: .center, spacing: 24) {
                    NavigationLink(destination: self.buildTimeSignaturePickerView()) {
                        Text(viewModel.controlsViewModel.timeSignatureLabel).font(Font.system(.footnote))
                    }
                    NavigationLink(destination: self.buildTempoPickerView()) {
                        Text(viewModel.controlsViewModel.tempoLabel).font(Font.system(.footnote))
                    }
                }.foregroundColor(Color.white.opacity(0.7))
                Button(action: { self.viewModel.toggleIsRunning() }, label: {
                    return Text(viewModel.controlsViewModel.toggleLabel)
                })
            }
        }
    }


    // MARK: Private helper methods

    private func buildTimeSignaturePickerView() -> TimeSignaturePickerView {
        let pickerViewModel = TimeSignaturePickerViewModel(timeSignature: viewModel.timeSignature)
        return TimeSignaturePickerView(viewModel: pickerViewModel, completion: { timeSignature in
            self.viewModel.set(timeSignature: timeSignature)
        })
    }


    private func buildTempoPickerView() -> TempoPickerView {
        let pickerViewModel = TempoPickerViewModel(tempo: viewModel.tempo)
        return TempoPickerView(viewModel: pickerViewModel, completion: { tempo in
            self.viewModel.set(tempo: tempo)
        })
    }
}
