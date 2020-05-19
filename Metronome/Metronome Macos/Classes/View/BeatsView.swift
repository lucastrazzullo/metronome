//
//  BeatsView.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct BeatsView: View {

    @ObservedObject private(set) var viewModel: BeatsViewModel

    var body: some View {
        HStack(alignment: .center, spacing: 1) {
            ForEach(viewModel.beats, id: \.id) { beatViewModel in
                BeatView(viewModel: beatViewModel)
            }
        }
    }
}
