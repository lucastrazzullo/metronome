//
//  MetronomeView.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct MetronomeView: View {

    let metronome: MetronomeController
    var model: MetronomeViewModel

    var body: some View {
        ZStack {
            ColorView(color: .black)
            BeatsView(model: model.beatViewModels)
            ChromeView(model: model.chromeViewModel, helperDidAppear: {
                self.metronome.reset()
            })
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
