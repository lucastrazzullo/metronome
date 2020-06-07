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

    private(set) var viewModel: SessionViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            BeatsView(viewModel: buildBeatsViewModel())
                .frame(height: 24, alignment: .center)
                .padding(.top, 12)
                .padding([.leading, .trailing], 4)

            ControlsView(viewModel: buildControlsViewModel())
        }
    }


    // MARK: Private helper methods

    private func buildBeatsViewModel() -> BeatsViewModel {
        return BeatsViewModel(sessionController: viewModel.controller)
    }


    private func buildControlsViewModel() -> ControlsViewModel {
        return ControlsViewModel(sessionController: viewModel.controller)
    }
}
