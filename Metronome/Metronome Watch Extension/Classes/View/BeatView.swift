//
//  BeatView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 19/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct BeatView: View {

    let model: BeatViewModel

    var body: some View {
        ZStack {
            self.background().edgesIgnoringSafeArea(.all)
            Text(String(model.label))
                .font(Font.system(.title))
                .foregroundColor(self.foreground())
        }.cornerRadius(8)
    }


    // MARK: Private helper methods

    private func background() -> Color {
        if model.isHighlighted {
            return Color.green
        } else {
            return Color.white.opacity(0.05)
        }
    }


    private func foreground() -> Color {
        if model.isHighlighted {
            return Color.white
        } else {
            return Color.white.opacity(0.1)
        }
    }
}
