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
            Color.black.edgesIgnoringSafeArea(.all)
            HStack(alignment: .center, spacing: 1) {
                ForEach(publisher.snapshot.beatViewModels, id: \.self) { beatViewModel in
                    BeatView(model: beatViewModel)
                }
            }
        }
    }
}
