//
//  BeatView.swift
//  Metronome Watch Extension
//
//  Created by luca strazzullo on 19/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct BeatView: View {

    @ObservedObject private(set) var viewModel: BeatViewModel

    var body: some View {
        ZStack {
            self.background().edgesIgnoringSafeArea(.all)
            Text(String(viewModel.label ?? ""))
                .font(Font.system(.title))
                .foregroundColor(self.foreground())
        }.cornerRadius(8)
    }


    // MARK: Private helper methods

    private func background() -> Color {
        if viewModel.isHighlighted {
            return Color.green
        } else {
            return Color.white.opacity(0.05)
        }
    }


    private func foreground() -> Color {
        if viewModel.isHighlighted {
            return Color.white
        } else {
            return Color.white.opacity(0.1)
        }
    }
}
