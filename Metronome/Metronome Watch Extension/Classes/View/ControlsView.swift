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
                NavigationLink(destination: tempoPickerView()) {
                    Text(viewModel.tempoLabel)
                }
                .buttonStyle(ShapedButtonStyle(highlighted: !viewModel.metronomeIsRunning, shape: .button3))

                NavigationLink(destination: timeSignaturePickerView()) {
                    Text(viewModel.timeSignatureLabel)
                }
                .buttonStyle(ShapedButtonStyle(highlighted: !viewModel.metronomeIsRunning, shape: .button4))
            }

            HStack(alignment: .center, spacing: 24) {
                Spacer()
                Button(action: viewModel.toggleIsRunning) {
                    Text(viewModel.metronomeTogglerLabel)
                }
                .buttonStyle(ShapedButtonStyle(highlighted: !viewModel.metronomeIsRunning, shape: .button6))
                Spacer()
            }
        }
    }


    // MARK: Private helper methods

    private func timeSignaturePickerView() -> some View {
        let viewModel = TimeSignaturePickerViewModel(controller: self.viewModel.controller)
        return TimeSignaturePickerView(viewModel: viewModel)
    }


    private func tempoPickerView() -> some View {
        let viewModel = TempoPickerViewModel(controller: self.viewModel.controller)
        return TempoPickerView(viewModel: viewModel)
    }
}
