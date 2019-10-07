//
//  MetronomeView.swift
//  Metronome Watch WatchKit Extension
//
//  Created by luca strazzullo on 7/10/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI

struct MetronomeView: View {

    var model: MetronomeViewModel

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 12) {
                HStack(alignment: .center, spacing: 1) {
                    ForEach(model.bits, id: \.index) { bitViewModel in
                        ZStack {
                            self.backgroundColor(for: bitViewModel.index).edgesIgnoringSafeArea(.all)
                            Text(String(bitViewModel.label))
                                .font(Font.system(.largeTitle))
                                .foregroundColor(self.foregroundColor(forBitAt: bitViewModel.index))
                        }.cornerRadius(8)
                    }
                }
                HStack(alignment: .center, spacing: 24) {
                    Text(model.timeSignatureLabel).font(Font.system(.footnote))
                    Text(model.tempoLabel).font(Font.system(.footnote))
                }.foregroundColor(Color.white.opacity(0.7))
                Button(action: {}, label: { return Text(self.model.toggleLabel) })
            }
        }
    }


    // MARK: Private helper methods

    private func backgroundColor(for index: Int) -> Color {
        if let currentIndex = model.currentBitIndex, currentIndex == index {
            return Color.yellow
        } else {
            return Color.white.opacity(0.05)
        }
    }


    private func foregroundColor(forBitAt index: Int) -> Color {
        if let currentIndex = model.currentBitIndex, currentIndex == index {
            return Color.white
        } else {
            return Color.white.opacity(0.1)
        }
    }
}
