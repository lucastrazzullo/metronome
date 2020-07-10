//
//  RemoteSessionView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 14/6/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct RemoteSessionView: View {

    @ObservedObject private(set) var viewModel: RemoteSessionViewModel

    var body: some View {
        if viewModel.isActiveSession {
            return AnyView(buildControlsView())
        } else {
            return AnyView(buildWaitingView())
        }
    }


    // MARK: Private helper methods

    private func buildWaitingView() -> some View {
        return EmptyView()
    }


    private func buildControlsView() -> some View {
        let controlsViewModel = ControlsViewModel(controller: viewModel.controller)
        let tapTempoViewModel = TapTempoPickerViewModel(controller: viewModel.controller)
        let tempoViewModel = TempoPickerViewModel(controller: viewModel.controller)
        let timeSignatureViewModel = TimeSignaturePickerViewModel(controller: viewModel.controller)

        tapTempoViewModel.isAutomaticCommitActive = true
        tempoViewModel.isAutomaticCommitActive = true
        timeSignatureViewModel.isAutomaticCommitActive = true

        return ControlsView(controlsViewModel: controlsViewModel, tapTempoViewModel: tapTempoViewModel, tempoViewModel: tempoViewModel, timeSignatureViewModel: timeSignatureViewModel)
    }
}
