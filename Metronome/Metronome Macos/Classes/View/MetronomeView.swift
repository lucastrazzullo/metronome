//
//  MetronomeView.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct MetronomeView: View {

    let metronome: MetronomeController
    var model: MetronomeViewModel

    var body: some View {
        ZStack {
            ColorView(color: .black)
            BeatsView(model: model.beatViewModels)
        }
    }
}


struct MetronomeView_Previews: PreviewProvider {

    static var previews: some View {
        let configuration = MetronomeConfiguration(timeSignature: .default, tempo: .default)
        let metronome = MetronomeController(with: configuration)
        let snapshot = MetronomeStatePublisher.Snapshot(configuration: configuration, isRunning: false, currentBeat: nil)
        let viewModel = MetronomeViewModel(snapshot: snapshot)
        return MetronomeView(metronome: metronome, model: viewModel)
    }
}
