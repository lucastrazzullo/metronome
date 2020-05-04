//
//  MetronomeView.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct MetronomeView: View {

    @EnvironmentObject var viewModel: MetronomeViewModel

    var body: some View {
        ZStack {
            ColorView(color: .black)
            BeatsView(model: viewModel.beatViewModels)
            ChromeView(model: viewModel.controlsViewModel, helperDidAppear: {
                self.viewModel.reset()
            })
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
