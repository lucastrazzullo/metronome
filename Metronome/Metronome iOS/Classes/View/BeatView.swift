//
//  BeatView.swift
//  Metronome iOS
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
            return Color("purple")
        case model.isHenhanced:
            return Color("gray")
        default:
            return .clear
        }
    }
}


struct BeatView_Previews: PreviewProvider {

    static var previews: some View {
        let models = [
            BeatViewModel(with: Beat(intensity: .normal, position: 0), isHighlighted: true, isHenhanced: true),
            BeatViewModel(with: Beat(intensity: .strong, position: 1), isHighlighted: false, isHenhanced: false),
            BeatViewModel(with: Beat(intensity: .normal, position: 2), isHighlighted: false, isHenhanced: true)
        ]
        return HStack {
            ForEach(models, id: \.self) { viewModel in
                BeatView(model: viewModel)
            }
        }
    }
}
