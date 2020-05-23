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
        ZStack(alignment: .center) {
            Circle()
                .foregroundColor(self.backgroundColor())

            Circle()
                .stroke(self.accentIndicatorColor(), lineWidth: 2)
        }
    }


    // MARK: Private helper methods

    private func backgroundColor() -> Color {
        if viewModel.state.contains(.highlighted) {
            return Palette.green.color
        } else {
            return Palette.gray.color
        }
    }


    private func foregroundColor() -> Color {
        if viewModel.state.contains(.highlighted) {
            return Palette.white.color
        } else {
            return Palette.gray.color
        }
    }


    private func accentIndicatorColor() -> Color {
        if viewModel.state.contains(.accented) {
            return Palette.purple.color
        } else {
            return .clear
        }
    }
}
