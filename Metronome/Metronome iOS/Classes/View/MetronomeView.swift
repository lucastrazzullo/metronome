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

    let metronome: Metronome
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
