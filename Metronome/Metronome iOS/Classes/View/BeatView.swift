//
//  BeatView.swift
//  Metronome iOS
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
            VStack {
                Text(viewModel.label ?? "").brandFont(.headline).foregroundColor(self.foreground())
                Circle().frame(width: 8, height: 8, alignment: .center).foregroundColor(self.henhanceColor())
            }
        }
    }


    // MARK: Private helper methods

    private func background() -> some View {
        if viewModel.isHighlighted {
            return LinearGradient(gradient: Gradient(colors: [Palette.green.color, Palette.blue.color]), startPoint: .topLeading, endPoint: .bottomTrailing)
        } else {
            return LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.05), Color.white.opacity(0.05)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }


    private func foreground() -> Color {
        if viewModel.isHighlighted {
            return Color.white
        } else {
            return Palette.gray.color
        }
    }


    private func henhanceColor() -> Color {
        switch true {
        case viewModel.isHenhanced && viewModel.isHighlighted:
            return Palette.purple.color
        case viewModel.isHenhanced:
            return Palette.gray.color
        default:
            return .clear
        }
    }
}
