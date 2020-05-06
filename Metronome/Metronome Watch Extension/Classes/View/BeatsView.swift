//
//  BeatsView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 6/5/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct BeatsView: View {

    @ObservedObject var viewModel: BeatsViewModel

    var body: some View {
        HStack(alignment: .center, spacing: 1) {
            ForEach(viewModel.beats, id: \.id) { beatViewModel in
                BeatView(viewModel: beatViewModel)
            }
        }
    }
}
