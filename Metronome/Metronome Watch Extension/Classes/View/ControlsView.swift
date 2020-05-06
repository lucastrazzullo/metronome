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
            HStack(alignment: .center, spacing: 24) {
                NavigationLink(destination: TimeSignaturePickerView(viewModel: viewModel.timeSignaturePickerViewModel())) {
                    Text(viewModel.timeSignatureLabel ?? "").font(Font.system(.footnote))
                }
                NavigationLink(destination: TempoPickerView(viewModel: viewModel.tempoPickerViewModel())) {
                    Text(viewModel.tempoLabel ?? "").font(Font.system(.footnote))
                }
            }.foregroundColor(Color.white.opacity(0.7))
            Button(action: { self.viewModel.toggleIsRunning() }, label: {
                return Text(viewModel.toggleLabel ?? "")
            })
        }
    }
}
