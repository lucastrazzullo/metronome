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
                ControlsView(isMetronomeRunning: viewModel.isMetronomeRunning, toggle: {
                    self.viewModel.toggleIsRunning()
                })
            }
        }
    }
}


struct MetronomeView_Previews: PreviewProvider {

    static var previews: some View {
        let metronome = Metronome(with: .default)
        let publisher = MetronomePublisher(metronome: metronome)
        let viewModel = MetronomeViewModel(metronomePublisher: publisher)
        return MetronomeView().environmentObject(viewModel)
    }
}
