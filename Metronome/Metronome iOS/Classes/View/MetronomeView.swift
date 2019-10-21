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

    @ObservedObject var publisher: SnapshotMetronomePublisher<MetronomeViewModel>


    // MARK: Body

    var body: some View {
        ZStack {
            ColorView(color: .black)
            BeatsView(model: publisher.snapshot.beatViewModels)
            ChromeView(model: publisher.snapshot.chromeViewModel, helperDidAppear: {
                self.publisher.metronome.reset()
            })
        }
    }
}
