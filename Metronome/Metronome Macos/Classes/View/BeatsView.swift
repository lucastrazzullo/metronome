//
//  BeatsView.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct BeatsView: View {

    var model: [BeatViewModel]

    var body: some View {
        HStack(alignment: .center, spacing: 1) {
            ForEach(model, id: \.self) { beatViewModel in
                BeatView(model: beatViewModel)
            }
        }
    }
}


struct BeatsView_Previews: PreviewProvider {

    static var previews: some View {
        let models = [
            BeatViewModel(with: Beat(intensity: .normal, position: 0), isHighlighted: true, isHenhanced: true),
            BeatViewModel(with: Beat(intensity: .strong, position: 1), isHighlighted: false, isHenhanced: false),
            BeatViewModel(with: Beat(intensity: .normal, position: 2), isHighlighted: false, isHenhanced: true)
        ]
        return BeatsView(model: models)
    }
}
