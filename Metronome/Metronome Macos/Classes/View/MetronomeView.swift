//
//  MetronomeView.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct MetronomeView: View {

    @EnvironmentObject var viewModel: MetronomeViewModel

    var body: some View {
        ZStack {
            ColorView(color: .black)
            VStack {
                BeatsView(model: viewModel.beatViewModels)
                ControlsView()
            }
        }
    }
}
