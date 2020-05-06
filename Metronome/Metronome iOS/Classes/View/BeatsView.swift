//
//  BeatsView.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 21/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct BeatsView: View {

    @ObservedObject var viewModel: BeatsViewModel

    var body: some View {
        HStack(alignment: .center, spacing: 1) {
            ForEach(viewModel.beats, id: \.id) { beatViewModel in
                return BeatView(viewModel: beatViewModel)
            }
        }
    }
}
