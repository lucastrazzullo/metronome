//
//  BeatView.swift
//  Metronome Macos
//
//  Created by luca strazzullo on 28/4/20.
//  Copyright © 2020 luca strazzullo. All rights reserved.
//

import SwiftUI

struct BeatView: View {

    @ObservedObject private(set) var viewModel: BeatViewModel

    var body: some View {
        ZStack {
            self.background().edgesIgnoringSafeArea(.all)
            VStack {
                Text(viewModel.label).foregroundColor(self.foreground())
                Circle().frame(width: 8, height: 8, alignment: .center).foregroundColor(self.accentColor())
            }
        }
    }


    // MARK: Private helper methods

    private func background() -> some View {
        if viewModel.state.contains(.highlighted) {
            return LinearGradient.oblique(gradient: Gradient(colors: [Palette.green.color, Palette.blue.color]), startPoint: .topLeading, endPoint: .bottomTrailing)
        } else {
            return LinearGradient.oblique(gradient: Gradient(colors: [Color.white.opacity(0.05), Color.white.opacity(0.05)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }


    private func foreground() -> Color {
        if viewModel.state.contains(.highlighted) {
            return Color.white
        } else {
            return Palette.gray.color
        }
    }


    private func accentColor() -> Color {
        switch viewModel.state {
        case [.highlighted, .accented]:
            return Palette.purple.color
        case [.accented]:
            return Palette.gray.color
        default:
            return .clear
        }
    }
}
