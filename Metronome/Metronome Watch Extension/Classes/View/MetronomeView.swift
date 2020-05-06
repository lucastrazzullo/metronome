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

    private(set) var viewModel: MetronomeViewModel


    // MARK: Body

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 12) {
                Spacer()
                BeatsView(viewModel: viewModel.beatsViewModel)
                ControlsView(viewModel: viewModel.controlsViewModel)
            }
        }
    }
}
