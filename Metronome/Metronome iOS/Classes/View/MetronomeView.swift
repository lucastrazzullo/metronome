//
//  MetronomeView.swift
//  Metronome
//
//  Created by luca strazzullo on 30/9/19.
//  Copyright © 2019 luca strazzullo. All rights reserved.
//

import SwiftUI
import Combine

struct MetronomeView: View {

    @ObservedObject var observed: ObservableMetronome<MetronomeViewModel>


    // MARK: Body

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            HStack(alignment: .center, spacing: 1) {
                ForEach(observed.snapshot.bits, id: \.index) { bitViewModel in
                    ZStack {
                        self.backgroundColor(for: bitViewModel.index).edgesIgnoringSafeArea(.all)
                        Text(String(bitViewModel.label))
                            .font(Font.system(.largeTitle))
                            .foregroundColor(self.foregroundColor(forBitAt: bitViewModel.index))
                    }
                }
            }
        }
    }


    // MARK: Private helper methods

    private func backgroundColor(for index: Int) -> Color {
        if observed.snapshot.isRunning, observed.snapshot.currentBitIndex == index {
            return Color("yellow")
        } else {
            return Color.white.opacity(0.05)
        }
    }


    private func foregroundColor(forBitAt index: Int) -> Color {
        if observed.snapshot.isRunning, observed.snapshot.currentBitIndex == index {
            return Color.white
        } else {
            return Color.white.opacity(0.1)
        }
    }
}
