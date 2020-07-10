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
        }.padding()
    }
}
