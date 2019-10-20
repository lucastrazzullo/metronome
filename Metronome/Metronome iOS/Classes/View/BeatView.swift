//
//  BeatView.swift
//  Metronome iOS
//
//  Created by luca strazzullo on 19/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct BeatView: View {

    var model: BeatViewModel

    var body: some View {
        ZStack {
            self.background().edgesIgnoringSafeArea(.all)
            VStack {
                Text(model.label).brandFont(.headline).foregroundColor(self.foreground())
                Circle().frame(width: 8, height: 8, alignment: .center).foregroundColor(self.henhanceColor())
            }
        }
    }


    // MARK: Private helper methods

    private func background() -> some View {
        if model.isHighlighted {
            return LinearGradient(gradient: Gradient(colors: [Color("green"), Color("blue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
        } else {
            return LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.05), Color.white.opacity(0.05)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }


    private func foreground() -> Color {
        if model.isHighlighted {
            return Color.white
        } else {
            return Color("gray")
        }
    }


    private func henhanceColor() -> Color {
        switch true {
        case model.isHenhanced && model.isHighlighted:
            return Color.white
        case model.isHenhanced:
            return Color("gray")
        default:
            return .clear
        }
    }
}
