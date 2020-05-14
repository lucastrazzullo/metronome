//
//  MetronomeView.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct MetronomeView: View {

    private(set) var viewModel: MetronomeViewModel

    var body: some View {
        ZStack {
            Color(Palette.black).edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 24) {
                BeatsView(viewModel: viewModel.beatsViewModel)
                ControlsView(viewModel: viewModel.controlsViewModel)
            }
        }
    }
}
